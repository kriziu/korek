import { Router } from 'express';
import Message from '../models/message.model';

const router = Router();

// CREATING NEW MESSAGE
router.post('/', async (req, res) => {
  try {
    const message = new Message({
      roomId: req.body.roomId,
      from: req.body.from,
      message: req.body.message,
    });

    try {
      message.save();
      res.status(201).json(message);
    } catch (err) {
      const msg = (err as Error).message;
      if (msg) return res.status(400).send({ error: msg });
      res.status(500).send();
    }
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(400).send({ error: msg });
    res.status(500).send();
  }
});

router.delete('/:roomId', async (req, res) => {
  try {
    const { roomId } = req.params;

    const messages = await Message.deleteMany({ roomId });
    res.json({
      msg: `Deleted room: ${roomId}. Total messages: ${messages.deletedCount}`,
    });
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(400).send({ error: msg });
    res.status(500).send();
  }
});

// GETTING ALL MESSEGES BY ROOM ID
router.get('/:roomId', async (req, res) => {
  try {
    const messages = await Message.find({ roomId: req.params.roomId });
    res.json(messages);
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(400).send({ error: msg });
    res.status(500).send();
  }
});

// GETTING ALL USERS THAT CHATTED BY USER ID
router.get('/', async (req, res) => {
  try {
    const { userId } = req.body;

    let roomsId: string[] = await Message.find({
      roomId: { $regex: '.*' + userId + '.*' },
    })
      .select('roomId')
      .distinct('roomId');

    roomsId = roomsId.map(roomId => {
      const ids = roomId.split('_');
      if (ids[0] === userId) return ids[1];
      return ids[0];
    });

    res.json(roomsId);
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(400).send({ error: msg });
    res.status(500).send();
  }
});

export default router;
