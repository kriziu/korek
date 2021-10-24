import { Router } from 'express';
import Message from '../models/message.model';
import { authenticateToken } from './authenticationController';

const router = Router();

// CREATING NEW MESSAGE
router.post('/', authenticateToken, async (req, res) => {
  try {
    const message = new Message({
      roomId: req.body.roomId,
      from: req.body.authId,
      message: req.body.message,
    });

    message.save();
    res.status(201).json(message);
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(400).send({ error: msg });
    res.status(500).send();
  }
});

router.delete('/:roomId', authenticateToken, async (req, res) => {
  try {
    const { roomId } = req.params;
    const { authId } = req.body;

    const ids = roomId.split('_');

    if (ids.includes(authId)) {
      const messages = await Message.deleteMany({ roomId });
      return res.json({
        msg: `Deleted room: ${roomId}. Total messages: ${messages.deletedCount}`,
      });
    }
    res.sendStatus(403);
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(400).send({ error: msg });
    res.status(500).send();
  }
});

// GETTING ALL MESSEGES BY ROOM ID
router.get('/:roomId', authenticateToken, async (req, res) => {
  try {
    const { roomId } = req.params;
    const { authId } = req.body;

    const ids = roomId.split('_');
    if (ids.includes(authId)) {
      const messages = await Message.find({ roomId: roomId });
      return res.json(messages);
    }
    res.sendStatus(403);
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(400).send({ error: msg });
    res.status(500).send();
  }
});

export default router;
