import { Router } from 'express';
import bcrypt from 'bcrypt';

import Message from '../models/message.model';
import User, { Subjects } from '../models/user.model';

const router = Router();

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

// GETTING ALL USERS THAT CHATTED BY USER ID
router.get('/chatted/:userId', async (req, res) => {
  try {
    const { userId } = req.params;

    let roomsId: string[] = await Message.find({
      roomId: { $regex: '.*' + userId + '.*' },
    })
      .select('roomId')
      .distinct('roomId');

    const usersId = roomsId.map(roomId => {
      const ids = roomId.split('_');
      if (ids[0] === userId) return ids[1];
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
      avatarId: req.body.avatarId,
      userType: req.body.userType,
      subjects: req.body.subjects,
    });

    try {
      const newUser = await user.save();
      res.status(201).json(newUser);
    } catch (err) {
      const msg = (err as Error).message;
      if (msg) return res.status(400).send({ error: msg });
      res.status(500).send();
    }
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
    if (await bcrypt.compare(req.body.password, user.password)) res.json(user);
    else res.json({ error: 'Bad password' });
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(500).send({ error: msg });
    res.status(500).send();
  }
});

// UPDATING ONE
router.patch('/:id', async (req, res) => {
  try {
    const user = await User.findByIdAndUpdate(
      { _id: req.params.id },
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