import { FC, useState } from 'react';

import { CSSTransition, SwitchTransition } from 'react-transition-group';

import Footer from '../../components/Footer/Footer';
import NavBar from '../../components/NavBar/NavBar';
import Chat from './components/Chat';
import UserList from './components/UserList';
import '../../styles/animations.css';
import { Center } from '../../components/Center';
import { AVATARS } from '../../contants';
import { Container, Img } from './Chats.elements';

export interface CurrentChat {
  firstName: string;
  lastName: string;
  avatarId: AVATARS;
  roomId: string;
}

const Chats: FC = () => {
  const [chat, setChat] = useState<CurrentChat>({
    firstName: '',
    lastName: '',
    avatarId: AVATARS.FEMALE_1,
    roomId: '',
  });

  return (
    <div>
      <div style={{ minHeight: '100vh' }}>
        <NavBar />
        <Container>
          <UserList setCurrentChat={setChat} chat={chat} />
          <SwitchTransition>
            <CSSTransition
              timeout={200}
              key={chat?.roomId}
              classNames="fade-fast"
            >
              {chat.roomId ? (
                <Chat {...chat} />
              ) : (
                <Center className="center">
                  <Img src="/images/hero_chat.svg" alt="Start chatting" />
                </Center>
              )}
            </CSSTransition>
          </SwitchTransition>
        </Container>
      </div>
      <Footer />
    </div>
  );
};

export default Chats;
