import React, { FC, useContext, useState } from 'react';

import { AiFillStar } from 'react-icons/ai';
import axios from 'axios';
import { toast } from 'react-toastify';

import {
  Invite,
  ModalHeading,
} from '../../pages/teachers/components/Teacher.elements';
import { Avatar } from '../Avatar';
import { Button } from '../Button';
import { Center } from '../Center';
import { Header3 } from '../Header';
import Modal from '../Modal';
import { loggedUserContext } from '../../context/loggedUser';

const { REACT_APP_SERVER_URL } = process.env;

interface WriteRateProps extends UserType {
  close: () => void;
}

const WriteRate: FC<WriteRateProps> = ({
  avatarId,
  _id,
  firstName,
  lastName,
  close,
}) => {
  const { token } = useContext(loggedUserContext);

  const [text, setText] = useState('');
  const [stars, setStars] = useState(0);

  const err = () =>
    toast.error('You already wrote rate about this teacher!', {
      position: 'top-center',
      autoClose: 10000,
      hideProgressBar: false,
      closeOnClick: true,
      pauseOnHover: true,
      draggable: true,
      progress: undefined,
    });

  const success = () =>
    toast.success('Rate sent!', {
      position: 'top-center',
      autoClose: 10000,
      hideProgressBar: false,
      closeOnClick: true,
      pauseOnHover: true,
      draggable: true,
      progress: undefined,
    });

  const handleSendRate = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    if (token && stars) {
      axios
        .post<{ error?: string }>(
          `${REACT_APP_SERVER_URL}/rates`,
          {
            teacherId: _id,
            stars: stars,
            message: text,
          },
          {
            headers: {
              Authorization: token,
            },
          }
        )
        .then(res => {
          close();
          console.log(res.status);
          if (res.data.error === 'You already created rate for this teacher.')
            err();
          else success();
        });
    }
  };

  const renderStars = (): JSX.Element[] => {
    const arr = Array.from(Array(5).keys());

    return arr.map((e, index) => {
      return (
        <AiFillStar
          key={index}
          style={{
            width: '3rem',
            height: '3rem',
            cursor: 'pointer',
            color:
              index + 1 <= stars ? 'var(--color-yellow)' : 'var(--color-black)',
            transition: 'var(--trans-default)',
          }}
          onClick={() => setStars(index + 1)}
        />
      );
    });
  };

  return (
    <Modal close={close}>
      <>
        <ModalHeading>
          <Avatar id={avatarId} />
          <Header3 style={{ marginTop: '1rem', maxWidth: '18rem' }}>
            {firstName} {lastName}
          </Header3>
        </ModalHeading>
        <form onSubmit={handleSendRate}>
          <Center style={{ marginBottom: '1rem', marginTop: '1rem' }}>
            {renderStars()}
          </Center>

          <Invite value={text} onChange={e => setText(e.target.value)} />
          <Button style={{ width: '100%' }} type="submit" onClick={() => {}}>
            Send
          </Button>
        </form>
      </>
    </Modal>
  );
};

export default WriteRate;
