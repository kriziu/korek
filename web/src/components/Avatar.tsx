import { FC } from 'react';

import styled from '@emotion/styled';

import { Center } from './Center';
import { Header2 } from './Header';
import Modal from './Modal';
import { AVATARS } from '../contants';

const Container = styled.div<{ active?: boolean }>`
  width: 6rem;
  height: 6rem;
  border-radius: 50%;
  overflow: hidden;
  transition: var(--trans-default);
  background-color: ${props =>
    props.active ? 'var(--color-gray)' : 'transparent'};

  :hover {
    cursor: pointer;
    background-color: var(--color-gray);
  }

  :active {
    background-color: transparent;
  }
`;

const GridList = styled.div`
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-template-rows: repeat(3, 1fr);
  gap: 3.5rem;
`;

type Sizes = {
  [key: string]: string;
};

const Avatar: FC<{ id: AVATARS; size?: string }> = ({ id, size = 'md' }) => {
  const sizes: Sizes = {
    md: '',
    lg: '15rem',
  };

  return (
    <Container style={{ minWidth: sizes[size], minHeight: sizes[size] }}>
      <img src={`/images/${id}.svg`} alt="Avatar" />
    </Container>
  );
};

const AvatarSelector: FC<{
  id: AVATARS;
  avatarSelect: (id: AVATARS) => void;
  close: () => void;
}> = ({ id, avatarSelect, close }) => {
  const renderAvatars = (): JSX.Element[] => {
    const avatars = [];

    for (let i = 1; i <= 6; i++) {
      avatars.push(<Avatar id={(AVATARS as any)[`FEMALE_${i}`]}></Avatar>);
    }

    for (let i = 1; i <= 6; i++) {
      avatars.push(<Avatar id={(AVATARS as any)[`MALE_${i}`]}></Avatar>);
    }

    return avatars.map(avatar => {
      return (
        <Container
          active={avatar.props.id === id ? true : false}
          onClick={() => avatarSelect(avatar.props.id)}
          key={avatar.props.id}
        >
          {avatar}
        </Container>
      );
    });
  };

  return (
    <Modal close={close}>
      <>
        <Header2 style={{ marginBottom: '2rem' }}>Select Avatar</Header2>
        <Center>
          <GridList>{renderAvatars()}</GridList>
        </Center>
      </>
    </Modal>
  );
};

export { Avatar, AvatarSelector };
