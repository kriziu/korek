import React, { FC, useContext, useState } from 'react';

import { AiFillStar } from 'react-icons/ai';
import { CSSTransition } from 'react-transition-group';
import axios from 'axios';

import { Avatar } from '../../../components/Avatar';
import { Button } from '../../../components/Button';
import { Header2, Header3 } from '../../../components/Header';
import {
  Container,
  Invite,
  ModalHeading,
  Rating,
  SubjectList,
} from './Teacher.elements';
import Modal from '../../../components/Modal';
import { loggedUserContext } from '../../../context/loggedUser';

const { REACT_APP_SERVER_URL } = process.env;

const Teacher: FC<UserType> = ({
  _id,
  firstName,
  lastName,
  price,
  subjects,
  avatarId,
}) => {
  const { user, token } = useContext(loggedUserContext);

  const [opened, setOpened] = useState(false);
  const [text, setText] = useState('');

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

  const handleInvite = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (token && text) {
      axios.post(
        `${REACT_APP_SERVER_URL}/messages`,
        {
          roomId: _id + '_' + user?._id,
          message: text,
        },
        {
          headers: {
            Authorization: token,
          },
        }
      );
      setOpened(false);
    }
  };

  return (
    <Container>
      <Avatar id={avatarId} />
      <Header3 style={{ marginTop: '1rem', maxWidth: '18rem' }}>
        {firstName} {lastName}
      </Header3>
      <SubjectList>{renderSubjects()}</SubjectList>

      <Rating>
        <AiFillStar />
        <Header3>4.7 | {price}$ / h</Header3>
      </Rating>
      <Button style={{ width: '100%' }} onClick={() => setOpened(true)}>
        Choose
      </Button>
      <CSSTransition
        in={opened}
        timeout={200}
        classNames="fade-fast"
        unmountOnExit
      >
        <Modal close={() => setOpened(false)}>
          <>
            <ModalHeading>
              <Avatar id={avatarId} />
              <Header3 style={{ marginTop: '1rem', maxWidth: '18rem' }}>
                {firstName} {lastName}
              </Header3>
            </ModalHeading>
            <form onSubmit={handleInvite}>
              <Header2 style={{ marginTop: '1rem' }}>
                How can I help you?
              </Header2>
              <Invite value={text} onChange={e => setText(e.target.value)} />
              <Button style={{ width: '100%' }} type="submit">
                Send
              </Button>
            </form>
          </>
        </Modal>
      </CSSTransition>
    </Container>
  );
};

export default Teacher;
