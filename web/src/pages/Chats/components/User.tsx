import { FC, useContext, useState } from 'react';

import styled from '@emotion/styled';
import { BsFillPencilFill } from 'react-icons/bs';
import { CSSTransition } from 'react-transition-group';

import { Avatar } from '../../../components/Avatar';
import { Button } from '../../../components/Button';
import { Header3 } from '../../../components/Header';
import {
  Container,
  SubjectList,
} from '../../teachers/components/Teacher.elements';
import { CurrentChat } from '../Chats';
import { loggedUserContext } from '../../../context/loggedUser';
import '../../../styles/animations.css';
import WriteRate from '../../../components/Rate/WriteRate';

const StyledSubjectList = styled(SubjectList)`
  li {
    margin: 0;
  }
`;

const RateBtn = styled.button`
  border: none;
  background-color: transparent;
  cursor: pointer;
  position: absolute;
  top: 2rem;
  right: 2rem;

  transition: var(--trans-default);

  :hover {
    svg {
      width: 2.2rem;
      height: 2.2rem;
    }
  }

  svg {
    transition: var(--trans-default);
    width: 2rem;
    height: 2rem;
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
  email,
  wallet,
  rate,
}) => {
  const { user } = useContext(loggedUserContext);

  const [writeRate, setWriteRate] = useState(false);

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
    <Container style={{ position: 'relative' }}>
      {user?.userType === 'student' && (
        <RateBtn onClick={() => setWriteRate(true)}>
          <BsFillPencilFill />
        </RateBtn>
      )}

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
      <CSSTransition
        in={writeRate}
        timeout={200}
        classNames="fade-fast"
        unmountOnExit
      >
        <WriteRate
          avatarId={avatarId}
          firstName={firstName}
          lastName={lastName}
          email={email}
          rate={rate}
          wallet={wallet}
          userType="teacher"
          price={price}
          _id={_id}
          subjects={subjects}
          close={() => setWriteRate(false)}
        />
      </CSSTransition>
    </Container>
  );
};

export default User;
