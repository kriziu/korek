import { RequestHandler } from 'express';
import jwt from 'jsonwebtoken';

export const authenticateToken: RequestHandler = (req, res, next) => {
  const token = req.headers['authorization'];

  if (!token) return res.sendStatus(401);
  else {
    jwt.verify(
      token,
      process.env.ACCESS_TOKEN_SECRET as string,
      (err: any, user: any) => {
        if (err) return res.sendStatus(403);
        req.body.authId = user._id;
        next();
      }
    );
  }
};
