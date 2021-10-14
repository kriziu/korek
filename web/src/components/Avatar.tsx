import { FC } from 'react';

import styled from '@emotion/styled';

import { Avatars } from '../types/Avatars';
import { Center } from './Center';
import { Header2 } from './Header';

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

const Background = styled.div`
  position: fixed;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  z-index: 100;
  background-color: rgba(0, 0, 0, 0.7);
`;

const Card = styled.div`
  width: 60rem;
  height: 40rem;
  background-color: var(--color-white);
  border-radius: 3rem;
  padding: 4rem 5rem;
`;

const GridList = styled.div`
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-template-rows: repeat(3, 1fr);
  gap: 3.5rem;
`;

const Avatar: FC<{ id: Avatars }> = ({ id }) => {
  return (
    <Container>
      <img src={`/images/${id}.svg`} alt="Avatar" />
    </Container>
  );
};

const AvatarSelector: FC<{
  id: Avatars;
  avatarSelect: (id: Avatars) => void;
  close: () => void;
}> = ({ id, avatarSelect, close }) => {
  const renderAvatars = (): JSX.Element[] => {
    const avatars = [];

    for (let i = 1; i <= 6; i++) {
      avatars.push(<Avatar id={(Avatars as any)[`female_${i}`]}></Avatar>);
    }

    for (let i = 1; i <= 6; i++) {
      avatars.push(<Avatar id={(Avatars as any)[`male_${i}`]}></Avatar>);
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
    <Background onClick={close}>
      <Center>
        <Card onClick={e => e.stopPropagation()}>
          <Header2>Select Avatar</Header2>
          <Center>
            <GridList>{renderAvatars()}</GridList>
          </Center>
        </Card>
      </Center>
    </Background>
  );
};

export { Avatar, AvatarSelector };
