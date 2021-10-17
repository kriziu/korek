import { Router } from 'express';
import bcrypt from 'bcrypt';
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

// GETTING USER BY CONNECTED ID
router.get('/byId/:id', async (req, res) => {
  try {
    const allUsers = await User.find();
    const users = allUsers.filter(user => {
      let returnUser = false;

      user.connected.forEach(connection => {
        if (connection._id === req.params.id) returnUser = true;
        console.log(connection);
      });

      if (returnUser) return true;
      return false;
    });

    res.json(users);
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
      avatarId: req.body.avatarId,
      userType: req.body.userType,
      subjects: req.body.subjects,
      connected: req.body.connected,
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

// CONNECTING
router.post('/connect/:id', async (req, res) => {
  try {
    const userToConnect = await User.findById(req.params.id);
    if (!userToConnect)
      return res
        .status(400)
        .json({ error: 'Cannot find user to connect with that id' });

    const userConnecting = await User.findById(req.body._id);
    if (!userConnecting)
      return res
        .status(400)
        .json({ error: 'Cannot find user connecting with that id' });

    userToConnect.connected.push({
      _id: userConnecting._id,
    });
    userConnecting.connected.push({
      _id: userToConnect._id,
    });

    await userToConnect.save();
    await userConnecting.save();

    res.json(userToConnect);
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(500).send({ error: msg });
    res.status(500).send();
  }
});

// DISCONNECTING
router.post('/disconnect/:id', async (req, res) => {
  try {
    const userToDisconnect = await User.findById(req.params.id);
    if (!userToDisconnect)
      return res
        .status(400)
        .json({ error: 'Cannot find user to disconnect with that id' });

    const userDisconnecting = await User.findById(req.body._id);
    if (!userDisconnecting)
      return res
        .status(400)
        .json({ error: 'Cannot find user disconnecting with that id' });

    let tempConnected = [];

    tempConnected = userToDisconnect.connected.filter(
      connection => connection._id !== userDisconnecting._id
    );

    console.log(req.body.subject);
    userToDisconnect.connected = tempConnected;

    tempConnected = userDisconnecting.connected.filter(
      connection => connection._id !== userToDisconnect._id
    );
    userDisconnecting.connected = tempConnected;

    await userToDisconnect.save();
    await userDisconnecting.save();

    res.json(userDisconnecting);
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(500).send({ error: msg });
    res.status(500).send();
  }
});

export default router;
