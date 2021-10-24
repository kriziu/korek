import { Router } from 'express';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';

import Message from '../models/message.model';
import User, { Subjects } from '../models/user.model';
import { authenticateToken } from './authenticationController';

const router = Router();

// GETTING ALL USERS THAT CHATTED BY USER ID
router.get('/chatted', authenticateToken, async (req, res) => {
  try {
    const { authId } = req.body;

    console.log(authId);

    let roomsId: string[] = await Message.find({
      roomId: { $regex: '.*' + authId + '.*' },
    })
      .select('roomId')
      .distinct('roomId');

    const usersId = roomsId.map(roomId => {
      const ids = roomId.split('_');
      if (ids[0] === authId) return ids[1];
      return ids[0];
    });

    const users = await User.find({ _id: { $in: usersId } });

    res.json(users);
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(400).send({ error: msg });
    res.status(500).send();
  }
});

// GETTING ONE
router.get('/:id', async (req, res) => {
  try {
    const user = await User.findById(req.params.id);
    if (!user) {
      return res.status(404).json({ message: 'Cannot find user with that id' });
    }
    res.json(user);
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(500).send({ error: msg });
    res.status(500).send();
  }
});

// GETTING ALL TEACHERS OR BY SUBJECTS
router.get('/', async (req, res) => {
  try {
    const teachers = await User.find({ userType: 'teacher' });

    const teachersWithSubjects = teachers.filter(teacher =>
      teacher.subjects.length === 0 ? false : true
    );

    console.log(req.body.authId);

    const subjects: Subjects[] = req.body.subjects;

    if (subjects) {
      const teachersBySubjects = teachersWithSubjects.filter(teacher => {
        let returnTeacher = false;

        teacher.subjects.forEach(subject => {
          if (subjects.includes(subject)) returnTeacher = true;
        });

        if (returnTeacher) return true;
        return false;
      });

      return res.json(teachersBySubjects);
    } else res.json(teachersWithSubjects);
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(500).send({ error: msg });
    res.status(500).send();
  }
});

// CREATING NEW
router.post('/', async (req, res) => {
  try {
    const userWithEmail = await User.findOne({ email: req.body.email });
    if (userWithEmail)
      return res.json({ error: 'Found user with that email.' });

    const hashedPassword = await bcrypt.hash(req.body.password, 10);

    const user = new User({
      firstName: req.body.firstName,
      lastName: req.body.lastName,
      email: req.body.email,
      password: hashedPassword,
      price: req.body.price,
      rate: 0,
      wallet: 0,
      avatarId: req.body.avatarId,
      userType: req.body.userType,
      subjects: req.body.subjects,
    });

    await user.save();

    const token = jwt.sign({ user }, process.env.ACCESS_TOKEN_SECRET as string);

    res.json({ token: token });
  } catch (err) {
    const msg = (err as Error).message;
    console.log(msg);
    if (msg) return res.status(500).send({ error: msg });
    res.status(500).send();
  }
});

// LOGGING
router.post('/login', async (req, res) => {
  const user = await User.findOne({ email: req.body.email }).select(
    '+password'
  );
  if (user == null)
    return res.json({ error: 'Cannot find user with that email' });

  try {
    if (await bcrypt.compare(req.body.password, user.password)) {
      const token = jwt.sign(
        { user },
        process.env.ACCESS_TOKEN_SECRET as string
      );

      res.json({ token: token });
    } else res.json({ error: 'Bad password' });
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(500).send({ error: msg });
    res.status(500).send();
  }
});

// UPDATING ONE
router.patch('/', authenticateToken, async (req, res) => {
  try {
    const user = await User.findByIdAndUpdate(
      { _id: req.body.authId },
      req.body,
      { new: true }
    );
    res.json(user);
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(500).send({ error: msg });
    res.status(500).send();
  }
});

export default router;
