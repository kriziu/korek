import { FC, useState } from 'react';

import { CSSTransition, SwitchTransition } from 'react-transition-group';

import Footer from '../../components/Footer/Footer';
import NavBar from '../../components/NavBar/NavBar';
import Chat from './components/Chat';
import UserList from './components/UserList';
import '../../styles/animations.css';
import { Center } from '../../components/Center';

export interface CurrentChat {
  firstName: string;
  lastName: string;
  avatarId: Avatars;
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
                    width: '100%',
                    height: 'auto',
                    flexDirection: 'column',
                    marginLeft: '-30rem',
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
