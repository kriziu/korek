import { FC, useContext, useEffect, useState } from 'react';

import axios from 'axios';
import { AiOutlineSearch } from 'react-icons/ai';
import { CSSTransition, TransitionGroup } from 'react-transition-group';

import { Header3 } from '../../../components/Header';
import { Input, InputIcon } from '../../../components/Input';
import User from './User';
import { Container, List } from './UserList.elements';
import { CurrentChat } from '../Chats';
import { loggedUserContext } from '../../../context/loggedUser';
import { AVATARS } from '../../../contants';
import '../../../styles/animations.css';
import { socket } from '../../../utils/socket';

const { REACT_APP_SERVER_URL } = process.env;

const UserList: FC<{
  setCurrentChat: React.Dispatch<React.SetStateAction<CurrentChat>>;
  chat: CurrentChat;
}> = ({ setCurrentChat, chat }) => {
  const { token, user } = useContext(loggedUserContext);

  const [users, setUsers] = useState<UserType[]>([]);

  useEffect(() => {
    // TODO WYWALA BLAD ALE DZIALA
    socket.on('deleted', (id: string) => {
      if (id === chat.roomId) {
        setCurrentChat({
          avatarId: AVATARS.FEMALE_1,
          firstName: '',
          lastName: '',
          roomId: '',
        });
      }

      const ids = id.split('_');
      const secondId = ids[0] === user?._id ? ids[1] : ids[0];

      setUsers(prev => prev.filter(userArr => userArr._id !== secondId));
    });
  }, [chat.roomId, setCurrentChat, user?._id]);

  useEffect(() => {
    token &&
      axios
        .get<UserType[]>(`${REACT_APP_SERVER_URL}/users/chatted`, {
          headers: {
            Authorization: token,
          },
        })
        .then(res => {
          setUsers(res.data);
        });
  }, [token]);

  useEffect(() => {
    users.forEach(userArr => {
      const roomId =
        user?.userType === 'teacher'
          ? user._id + '_' + userArr._id
          : userArr._id + '_' + user?._id;

      socket.emit('joinRoom', roomId);
    });
  }, [users, user?._id, user?.userType]);

  const handleDeleteUserChat = (_id: string) => {
    const roomId =
      user?.userType === 'teacher'
        ? user._id + '_' + _id
        : _id + '_' + user?._id;

    if (roomId === chat.roomId) {
      setCurrentChat({
        avatarId: AVATARS.FEMALE_1,
        firstName: '',
        lastName: '',
        roomId: '',
      });
    }

    socket.emit('deleteRoom', roomId);

    token &&
      axios.delete(`${REACT_APP_SERVER_URL}/messages/${roomId}`, {
        headers: {
          Authorization: token,
        },
      });

    setUsers(prev => prev.filter(user => user._id !== _id));
  };

  const renderUsers = (): JSX.Element[] => {
    return users.map(user => {
      return (
        <CSSTransition timeout={200} classNames="slide" key={user._id}>
          <li className="item">
            <User
              {...user}
              setCurrentChat={setCurrentChat}
              chat={chat}
              handleDeleteUserChat={handleDeleteUserChat}
            />
          </li>
        </CSSTransition>
      );
    });
  };

  return (
    <Container>
      <Header3 style={{ marginBottom: '2rem' }}>
        {user?.userType === 'teacher' ? 'Your students' : 'Your teachers'}
      </Header3>
      <InputIcon>
        <AiOutlineSearch />
        <Input placeholder="Search" />
      </InputIcon>

      <List>
        <TransitionGroup component={null}>{renderUsers()}</TransitionGroup>
      </List>
    </Container>
  );
};

export default UserList;
