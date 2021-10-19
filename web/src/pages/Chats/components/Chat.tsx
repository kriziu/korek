import React, { FC, useEffect, useState } from 'react';

import { io } from 'socket.io-client';

import { Avatar } from '../../../components/Avatar';
import { Button } from '../../../components/Button';
import { Header3 } from '../../../components/Header';
import { MessageType } from '../../../types/Message';
import { StudentType } from '../../../types/Student';
import { TeacherType } from '../../../types/Teacher';
import { Bottom, Message, Messages, StyledInput, Top } from './Chat.elements';

const { REACT_APP_SERVER_URL } = process.env;

const socket = io(REACT_APP_SERVER_URL || '');

const id = Math.round(Math.random() * 100).toString();

const Chat: FC<TeacherType | StudentType> = ({
  firstName,
  lastName,
  _id,
  avatarId,
}) => {
  const [messages, setMessages] = useState<MessageType[]>([]);
  const [message, setMessage] = useState('');

  useEffect(() => {
    socket.emit('joinRoom', '123');

    socket.on('receive', (msg: MessageType) => {
      setMessages(prev => [...prev, msg]);
    });
  }, []);

  const handleSendMessage = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    socket.emit('send', {
      roomId: '123',
      message,
      from: id,
    });
    setMessage('');
  };

  const renderMessages = (): JSX.Element[] => {
    return messages.map((messageArr, index) => {
      return (
        <Message key={index} mine={messageArr.from === id}>
          {messageArr.message}
        </Message>
      );
    });
  };

  return (
    <div style={{ width: '100%' }}>
      <Top>
        <Avatar id={avatarId} />
        <Header3 style={{ marginLeft: '1rem' }}>
          {firstName} {lastName}
        </Header3>
        <Button>Enter room</Button>
        <Button secondary>Pay</Button>
      </Top>
      <Messages>{renderMessages()}</Messages>
      <Bottom onSubmit={handleSendMessage}>
        <StyledInput
          value={message}
          onChange={e => setMessage(e.target.value)}
        />
        <Button type="submit">Send</Button>
      </Bottom>
    </div>
  );
};

export default Chat;
