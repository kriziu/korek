import { FC, useEffect, useState } from 'react';

import axios from 'axios';
import { AiOutlineSearch } from 'react-icons/ai';

import { Header3 } from '../../../components/Header';
import { Input, InputIcon } from '../../../components/Input';
import User from './User';
import { Container, List } from './UserList.elements';
import { CurrentChat } from '../Chats';

const { REACT_APP_SERVER_URL } = process.env;

const UserList: FC<{
  setCurrentChat: React.Dispatch<React.SetStateAction<CurrentChat | undefined>>;
}> = ({ setCurrentChat }) => {
  const [users, setUsers] = useState<UserType[]>([]);

  useEffect(() => {
    axios.get<UserType[]>(`${REACT_APP_SERVER_URL}/users`).then(res => {
      setUsers(res.data);
    });
  }, []);

  const renderUsers = (): JSX.Element[] => {
    return users.map(user => {
      return (
        <li className="item" key={user._id}>
          <User {...user} setCurrentChat={setCurrentChat} />
        </li>
      );
    });
  };

  return (
    <Container>
      <Header3 style={{ marginBottom: '2rem' }}>Your teachers</Header3>
      <InputIcon>
        <AiOutlineSearch />
        <Input placeholder="Search" />
      </InputIcon>
      <List>{renderUsers()}</List>
    </Container>
  );
};

export default UserList;
