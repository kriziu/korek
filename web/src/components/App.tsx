import { FC, useEffect } from 'react';

import io from 'socket.io-client';
import { HashRouter as Router } from 'react-router-dom';
import 'react-toastify/dist/ReactToastify.css';
import { ToastContainer } from 'react-toastify';

import { GlobalStyles } from '../styles/GlobalStyles';
import AnimatedRouter from './AnimatedRouter';
import { MessageType } from '../types/Message';

const { REACT_APP_SERVER_URL } = process.env;

const socket = io(REACT_APP_SERVER_URL || '');

const id = Math.round(Math.random() * 100);

const App: FC = () => {
  useEffect(() => {
    socket.emit('joinRoom', '123');

    socket.emit('send', {
      roomId: '123',
      message: 'elo',
      from: id,
    });
    socket.on('receive', (msg: MessageType) => console.log(msg));
  });

  return (
    <>
      <GlobalStyles />
      <ToastContainer />
      <Router>
        <AnimatedRouter />
      </Router>
    </>
  );
};

export default App;
