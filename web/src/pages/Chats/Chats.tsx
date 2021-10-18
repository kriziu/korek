import { FC } from 'react';
import Footer from '../../components/Footer/Footer';
import NavBar from '../../components/NavBar/NavBar';
import { Avatars } from '../../types/Avatars';
import Chat from './components/Chat';
import TeacherList from './components/TeachersList';

const Chats: FC = () => {
  return (
    <div>
      <div style={{ minHeight: '100vh' }}>
        <NavBar />
        <div style={{ display: 'flex' }}>
          <TeacherList />
          <Chat
            firstName="Bruno"
            lastName="Dzięcielski"
            avatarId={Avatars.male_1}
            _id="1"
            connected={[]}
          />
        </div>
      </div>
      <Footer />
    </div>
  );
};

export default Chats;
