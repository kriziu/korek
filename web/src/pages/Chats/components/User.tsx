import { FC, useContext } from 'react';

import styled from '@emotion/styled';

import { Avatar } from '../../../components/Avatar';
import { Button } from '../../../components/Button';
import { Header3 } from '../../../components/Header';
import {
  Container,
  SubjectList,
} from '../../teachers/components/Teacher.elements';
import { CurrentChat } from '../Chats';
import { loggedUserContext } from '../../../context/loggedUser';

const StyledSubjectList = styled(SubjectList)`
  li {
    margin: 0;
  }
`;

interface UserProps extends UserType {
  setCurrentChat: React.Dispatch<React.SetStateAction<CurrentChat>>;
  handleDeleteUserChat: (_id: string) => void;
  chat: CurrentChat;
}

const User: FC<UserProps> = ({
  avatarId,
  firstName,
  lastName,
  price,
  _id,
  subjects,
  setCurrentChat,
  handleDeleteUserChat,
}) => {
  const { user } = useContext(loggedUserContext);

  const renderSubjects = (): JSX.Element[] => {
    return subjects.map(subject => {
      return (
        <li key={subject}>
          {subject[0].toUpperCase()}
          {subject.slice(1)}
        </li>
      );
    });
  };

  const handleSetCurrentChat = () => {
    setCurrentChat({
      avatarId,
      firstName,
      lastName,
      roomId:
        user?.userType === 'teacher'
          ? user._id + '_' + _id
          : _id + '_' + user?._id,
    });
  };

  return (
    <Container>
      <Avatar id={avatarId} />
      <Header3 style={{ marginTop: '1rem', maxWidth: '18rem' }}>
        {firstName} {lastName}
      </Header3>
      <StyledSubjectList>{renderSubjects()}</StyledSubjectList>

      {user?.userType === 'student' && (
        <Header3 style={{ marginTop: '1rem' }}>{price}$ / h</Header3>
      )}
      <Button
        style={{ width: '100%', margin: '1rem 0' }}
        onClick={handleSetCurrentChat}
      >
        Chat
      </Button>
      <Button
        style={{ width: '100%' }}
        secondary
        onClick={() => handleDeleteUserChat(_id)}
      >
        Revoke
      </Button>
    </Container>
  );
};

export default User;
