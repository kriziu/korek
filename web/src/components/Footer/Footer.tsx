import { FC } from 'react';

import { AiFillInstagram, AiOutlineTwitter } from 'react-icons/ai';
import { BsFacebook } from 'react-icons/bs';

import { Header3, SmallHeader } from '../Header';
import { Container } from './Footer.elements';

const Footer: FC = () => {
  return (
    <Container>
      <div className="flex">
        <div>
          <Header3
            style={{
              letterSpacing: '3px',
              textAlign: 'left',
              marginBottom: '.5rem',
            }}
          >
            KOREK
          </Header3>
          <SmallHeader
            style={{
              textAlign: 'left',
            }}
          >
            Application to make students <br /> knowledge better
          </SmallHeader>
          <div className="flex" style={{ width: '10rem', marginTop: '1rem' }}>
            <AiFillInstagram />
            <BsFacebook />
            <AiOutlineTwitter />
          </div>
        </div>
      </div>
      <div className="flex" style={{ marginTop: '4rem', width: '100%' }}>
        <SmallHeader>Copyright &copy; 2021 HackHeroes</SmallHeader>
        <SmallHeader>Powered by Us</SmallHeader>
      </div>
    </Container>
  );
};

export default Footer;
