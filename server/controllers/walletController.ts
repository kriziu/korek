import { Router } from 'express';
import jwt from 'jsonwebtoken';

import User from '../models/user.model';
import { authenticateToken } from './authenticationController';

const router = Router();

// PAYING
router.post('/pay', authenticateToken, async (req, res) => {
  let { authId, teacherId, much } = req.body;

  if (much < 0) much = 0;

  try {
    const user = await User.findById(authId);
    const userToPay = await User.findById(teacherId);

    if (!userToPay || !user) {
      return res.sendStatus(404);
    }

    if (user.wallet < much) {
      return res.json({ error: 'You do not have money to pay.' });
    }

    user.wallet -= much;
    userToPay.wallet += much;

    await user.save();
    await userToPay.save();

    const token = jwt.sign({ user }, process.env.ACCESS_TOKEN_SECRET as string);

    res.json({ token: token });
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(400).send({ error: msg });
    res.status(500).send();
  }
});

// DEPOSIT
router.post('/deposit', authenticateToken, async (req, res) => {
  let { authId, much } = req.body;

  if (much < 0) much = 0;

  try {
    const user = await User.findById(authId);

    if (!user) {
      return res.sendStatus(404);
    }

    user.wallet += much;
    await user.save();

    const token = jwt.sign({ user }, process.env.ACCESS_TOKEN_SECRET as string);

    res.json({ token: token });
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(400).send({ error: msg });
    res.status(500).send();
  }
});

// WITHDRAW
router.post('/withdraw', authenticateToken, async (req, res) => {
  let { authId, much } = req.body;

  if (much < 0) much = 0;

  try {
    const user = await User.findById(authId);

    if (!user) {
      return res.sendStatus(404);
    }

    if (user.wallet < much) {
      return res.json({ error: 'You do not have money to withdraw.' });
    }

    user.wallet -= much;
    await user.save();

    const token = jwt.sign({ user }, process.env.ACCESS_TOKEN_SECRET as string);

    res.json({ token: token });
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(400).send({ error: msg });
    res.status(500).send();
  }
});

export default router;
