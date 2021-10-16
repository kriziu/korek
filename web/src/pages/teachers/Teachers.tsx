import { FC } from 'react';

import { useHistory } from 'react-router';

import { Button } from '../../components/Button';
import { Header1, Header2, SmallHeader } from '../../components/Header';
import { Center } from '../../components/Center';
import Footer from '../../components/Footer/Footer';
import NavBar from '../../components/NavBar/NavBar';
import { Input, InputIcon } from '../../components/Input';
import { AiOutlineSearch } from 'react-icons/ai';
import TeacherList from './components/TeacherList';

const Teachers: FC = () => {
  const history = useHistory();

  const handleLoginButton = () => history.push('/login');
  const handleRegisterButton = () => history.push('/register');

  return (
    <div>
      <div style={{ minHeight: '100vh' }}>
        <NavBar />
        <Header1>
          Learn Anytime, Anywhere <br /> and Accelerate Future
        </Header1>
        <SmallHeader style={{ marginBottom: '5rem' }}>
          We believe everyone can make something amazing!
        </SmallHeader>

        <Center style={{ marginBottom: '5rem' }}>
          <InputIcon style={{ width: '60rem' }}>
            <AiOutlineSearch />
            <Input placeholder="Search for teachers" />
          </InputIcon>
          <Button style={{ padding: '1.4rem 4rem' }}>Search</Button>
        </Center>
        <Header2>Popular Teachers</Header2>
        <TeacherList />
      </div>
      <Footer />
    </div>
  );
};

export default Teachers;
