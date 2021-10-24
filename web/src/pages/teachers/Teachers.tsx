import { FC, useState } from 'react';

import styled from '@emotion/styled';

import { Button } from '../../components/Button';
import { Header1, Header2, SmallHeader } from '../../components/Header';
import { Center } from '../../components/Center';
import Footer from '../../components/Footer/Footer';
import NavBar from '../../components/NavBar/NavBar';
import { Input, InputIcon } from '../../components/Input';
import { AiOutlineSearch } from 'react-icons/ai';
import TeacherList from './components/TeacherList';
import { breakpoints } from '../../styles/breakpoints';

const StyledInIcon = styled(InputIcon)`
  width: 60rem;

  @media screen and (max-width: ${breakpoints.sm}) {
    width: 30rem;
  }
`;

const Teachers: FC = () => {
  const [search, setSearch] = useState('');
  const [tempSearch, setTempSearch] = useState('');

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
        <form
          onSubmit={e => {
            e.preventDefault();
            setSearch(tempSearch);
          }}
        >
          <Center style={{ marginBottom: '5rem' }}>
            <StyledInIcon>
              <AiOutlineSearch />
              <Input
                placeholder="Search for teachers"
                value={tempSearch}
                onChange={e => setTempSearch(e.target.value)}
              />
            </StyledInIcon>
            <Button style={{ padding: '1.4rem 4rem' }}>Search</Button>
          </Center>
        </form>
        <Header2>Popular Teachers</Header2>
        <TeacherList search={search} />
      </div>
      <Footer />
    </div>
  );
};

export default Teachers;
