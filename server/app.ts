import express from 'express';
import mongoose from 'mongoose';
import cors from 'cors';

import userController from './controllers/userController';

const app = express();
const port = process.env.PORT || 8080;

// DATABASE
mongoose.connect(
  `mongodb+srv://admin:${'4hGgszYmxZqjvOD1'}@cluster0.wqs9m.mongodb.net/Cluster0?retryWrites=true&w=majority`,
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
