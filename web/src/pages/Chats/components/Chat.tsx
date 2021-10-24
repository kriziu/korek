import React, { FC, useContext, useEffect, useRef, useState } from 'react';

import axios from 'axios';
import { CSSTransition, TransitionGroup } from 'react-transition-group';

import { Avatar } from '../../../components/Avatar';
import { Button } from '../../../components/Button';
import { Header3 } from '../../../components/Header';
import {
  Bottom,
  Container,
  Message,
  Messages,
  StyledInput,
  Top,
} from './Chat.elements';
import '../../../styles/animations.css';
import { CurrentChat } from '../Chats';
import { loggedUserContext } from '../../../context/loggedUser';
import { socket } from '../../../utils/socket';

const { REACT_APP_SERVER_URL } = process.env;

const Chat: FC<CurrentChat> = ({ firstName, lastName, avatarId, roomId }) => {
  const { user, token } = useContext(loggedUserContext);

  const [messages, setMessages] = useState<MessageType[]>([]);
  const [message, setMessage] = useState('');
  const ref = useRef<HTMLUListElement>(null);

  useEffect(() => {
    if (token) {
      socket.emit('joinRoom', roomId);

      socket.on('receive', (msg: MessageType) => {
        setMessages(prev => [...prev, msg]);
      });

      axios
        .get<MessageType[]>(`${REACT_APP_SERVER_URL}/messages/${roomId}`, {
          headers: {
            Authorization: token,
          },
        })
        .then(res => {
          setMessages(res.data);

          ref.current?.scrollTo({
            top: ref.current.scrollHeight,
          });
        });
    }

    return () => {
      socket.off('receive');
    };
  }, [roomId, user, token]);

  useEffect(() => {
    messages.length &&
      messages[messages.length - 1].from === user?._id &&
      ref.current?.scrollTo({
        top: ref.current.scrollHeight,
        behavior: 'smooth',
      });
  }, [messages, user?._id]);

  const handleSendMessage = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (!message) return;
    socket.emit('send', {
      roomId,
      message,
      from: user?._id,
    });
    token &&
      axios.post(
        `${REACT_APP_SERVER_URL}/messages`,
        {
          roomId,
          message,
        },
        {
          headers: {
            Authorization: token,
          },
        }
      );
    setMessage('');
  };

  const renderMessages = (): JSX.Element[] => {
    return messages.map((messageArr, index) => {
      return (
        <CSSTransition key={index} classNames="slide" timeout={200}>
          <Message mine={messageArr.from === user?._id}>
            {messageArr.message}
          </Message>
        </CSSTransition>
      );
    });
  };

  return (
    <Container>
      <Top>
        <Avatar id={avatarId} />
        <Header3 style={{ marginLeft: '1rem' }}>
          {firstName} {lastName}
        </Header3>
        <Button>Enter room</Button>
        {user?.userType === 'student' && <Button secondary>Pay</Button>}
      </Top>
      <div style={{ width: '80%' }}>
        <Messages ref={ref}>
          <TransitionGroup component={null}>{renderMessages()}</TransitionGroup>
        </Messages>
        <Bottom onSubmit={handleSendMessage}>
          <StyledInput
            value={message}
            onChange={e => setMessage(e.target.value)}
          />
          <Button type="submit">Send</Button>
        </Bottom>
      </div>
    </Container>
  );
};

export default Chat;
