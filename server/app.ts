import express from 'express';
import mongoose from 'mongoose';
import cors from 'cors';
import dotenv from 'dotenv';

import userController from './controllers/userController';

dotenv.config();

const app = express();
const port = process.env.PORT || 8080;

const { DB_PASS } = process.env;

// DATABASE
mongoose.connect(
  `mongodb+srv://admin:${DB_PASS}@cluster0.wqs9m.mongodb.net/Cluster0?retryWrites=true&w=majority`,
  err => {
    if (!err) console.log('Connection succes');
    else console.log('Error in connection: ' + err);
  }
);

app.use(express.json());
app.use(cors());

app.use('/users', userController);

app.get('/', (req, res) => {
  res.send('Server running...');
});

app.listen(port);
