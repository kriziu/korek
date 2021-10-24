import { Router } from 'express';
import Rate from '../models/rate.model';
import User from '../models/user.model';
import { authenticateToken } from './authenticationController';

const router = Router();

const calculateRate = async (teacherId: string) => {
  const rates = await Rate.find({ teacherId });

  if (!rates.length) {
    await User.findByIdAndUpdate(teacherId, {
      rate: 0,
    });
  } else {
    let stars = 0;
    rates.forEach(rate => {
      stars += rate.stars;
    });
    stars = stars / rates.length;
    await User.findByIdAndUpdate(teacherId, {
      rate: parseFloat(stars.toFixed(1)),
    });
  }
};

// CREATING NEW RATE
router.post('/', authenticateToken, async (req, res) => {
  const { authId, teacherId, stars, message } = req.body;

  try {
    const oldRate = await Rate.find({ teacherId, from: authId });

    if (oldRate[0]) {
      return res.json({ error: 'You already created rate for this teacher.' });
    }

    const newRate = new Rate({
      teacherId,
      stars,
      message,
      from: authId,
    });

    await newRate.save();
    await calculateRate(teacherId);

    res.status(201).json(newRate);
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(400).send({ error: msg });
    res.status(500).send();
  }
});

router.delete('/:rateId', authenticateToken, async (req, res) => {
  try {
    const { rateId } = req.params;
    const { authId } = req.body;

    const rate = await Rate.findById(rateId);

    if (!rate) {
      return res.sendStatus(404);
    }

    if (!rate?.from.equals(authId)) {
      return res.sendStatus(403);
    }

    await rate?.delete();
    await calculateRate(rate.teacherId);

    return res.json(rate);
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(400).send({ error: msg });
    res.status(500).send();
  }
});

// GETTING ALL RATES BY TEACHER ID
router.get('/:teacherId', async (req, res) => {
  try {
    const { teacherId } = req.params;

    const rates = await Rate.find({ teacherId }).populate('from');
    return res.json(rates);
  } catch (err) {
    const msg = (err as Error).message;
    if (msg) return res.status(400).send({ error: msg });
    res.status(500).send();
  }
});

export default router;
