import { FC } from 'react';

import { useHistory } from 'react-router';

import { Button } from '../../components/Button';
import { Header1, SmallHeader } from '../../components/Header';
import { Nav } from './components/Nav';
import { Center } from '../../components/Center';
import { BigButton } from './components/BigButton';
import Footer from '../../components/Footer/Footer';
import styled from '@emotion/styled';
import { breakpoints } from '../../styles/breakpoints';
import { PhoneContainer } from '../../components/Container';

const Img = styled.img`
  @media screen and (max-width: ${breakpoints.sm}) {
    width: 40rem;
    height: 40rem;
  }
`;

const Hero: FC = () => {
  const history = useHistory();

  const handleLoginButton = () => history.push('/login');
  const handleRegisterButton = () => history.push('/register');

  return (
    <div>
      <div style={{ minHeight: '100vh' }}>
        <Nav>
          <h3>KOREK</h3>
          <div>
            <Button
              secondary={true}
              style={{ marginRight: '2rem' }}
              onClick={handleLoginButton}
            >
              Login
            </Button>
            <Button onClick={handleRegisterButton}>Register</Button>
          </div>
        </Nav>
        <PhoneContainer>
          <Header1>
            Learn Anytime, Anywhere <br /> and Accelerate Future
          </Header1>
          <SmallHeader style={{ marginBottom: '5rem' }}>
            We believe everyone can make something amazing!
          </SmallHeader>

          <Center style={{ marginBottom: '5rem' }}>
            <Img src="/images/hero_learning.svg" alt="Study online" />
          </Center>

          <Header1>Join us to make world better!</Header1>
          <Center style={{ marginTop: '2rem', paddingBottom: '8rem' }}>
            <BigButton onClick={handleRegisterButton}>Join now</BigButton>
          </Center>
        </PhoneContainer>
      </div>
      <Footer />
    </div>
  );
};

export default Hero;
