import { FC } from 'react';

import styled from '@emotion/styled';

import { Center } from './Center';

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
  min-height: 40rem;
  background-color: var(--color-white);
  border-radius: 3rem;
  padding: 4rem 5rem;
`;

const Modal: FC<{ close: () => void; children: JSX.Element }> = ({
  close,
  children,
}) => {
  return (
    <Background onClick={close}>
      <Center>
        <Card onClick={e => e.stopPropagation()}>{children}</Card>
      </Center>
    </Background>
  );
};

export default Modal;
