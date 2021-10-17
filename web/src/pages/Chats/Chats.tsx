import { FC } from 'react';
import Footer from '../../components/Footer/Footer';
import NavBar from '../../components/NavBar/NavBar';
import Chat from './components/Chat';
import TeacherList from './components/TeachersList';

const Chats: FC = () => {
  return (
    <div>
      <div style={{ minHeight: '100vh' }}>
        <NavBar />
        <div style={{ display: 'flex' }}>
          <TeacherList />
          <Chat />
        </div>
      </div>
      <Footer />
    </div>
  );
};

export default Chats;
