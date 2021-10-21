import { FC, useState } from 'react';

import { CSSTransition, SwitchTransition } from 'react-transition-group';

import Footer from '../../components/Footer/Footer';
import NavBar from '../../components/NavBar/NavBar';
import Chat from './components/Chat';
import UserList from './components/UserList';
import '../../styles/animations.css';
import { Center } from '../../components/Center';
import { AVATARS } from '../../contants';

export interface CurrentChat {
  firstName: string;
  lastName: string;
  avatarId: AVATARS;
  roomId: string;
}

const Chats: FC = () => {
  const [chat, setChat] = useState<CurrentChat>();

  return (
    <div>
      <div style={{ minHeight: '100vh' }}>
        <NavBar />
        <div style={{ display: 'flex' }}>
          <UserList setCurrentChat={setChat} />
          <SwitchTransition>
            <CSSTransition
              timeout={200}
              key={chat?.roomId}
              classNames="fade-fast"
            >
              {chat ? (
                <Chat {...chat} />
              ) : (
                <Center
                  style={{
                    flex: 1,
                    height: 'auto',
                    flexDirection: 'column',
                    marginLeft: '-30rem',
                    pointerEvents: 'none',
                  }}
                >
                  <img src="/images/hero_chat.svg" alt="Start chatting" />
                </Center>
              )}
            </CSSTransition>
          </SwitchTransition>
        </div>
      </div>
      <Footer />
    </div>
  );
};

export default Chats;
