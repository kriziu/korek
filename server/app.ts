import express from 'express';
import mongoose from 'mongoose';
import cors from 'cors';
import dotenv from 'dotenv';
import http from 'http';
import { Server, Socket } from 'socket.io';

import userController from './controllers/userController';
import messageController from './controllers/messageController';
import { MessageType } from './models/message.model';

dotenv.config();

const app = express();
const server = http.createServer(app);
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

app.use('/messages', messageController);

app.get('/', (req, res) => {
  res.send('Server running...');
});

// SOCKET IO
const io = new Server(server, {
  cors: {
    origin: '*',
  },
});

io.on('connection', (socket: Socket) => {
  socket.on('createRoom', (id: string) => {
    console.log(id);
    socket.broadcast.emit('created', id);
  });

  socket.on('joinRoom', (id: string) => {
    socket.join(id);
  });

  socket.on('send', (msg: MessageType) => {
    io.to(msg.roomId).emit('receive', msg);
  });

  socket.on('deleteRoom', (id: string) => {
    io.to(id).emit('deleted', id);
  });
});

server.listen(port);
