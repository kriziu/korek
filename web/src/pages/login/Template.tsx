import { FC } from 'react';

import { IoReturnUpBack } from 'react-icons/io5';
import { useHistory } from 'react-router';

import { Center } from '../../components/Center';
import { BackBtn, Background, Card } from './Elements';

const Template: FC<{ children: JSX.Element }> = ({ children }) => {
  const history = useHistory();

  const handleBackBtnClick = () => history.push('/');

  return (
    <Background>
      <BackBtn onClick={handleBackBtnClick}>
        <IoReturnUpBack />
      </BackBtn>
      <Center>
        <Card>{children}</Card>
      </Center>
    </Background>
  );
};

export default Template;
