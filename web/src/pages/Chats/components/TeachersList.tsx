import { FC } from 'react';

import { AiOutlineSearch } from 'react-icons/ai';

import { Header3 } from '../../../components/Header';
import { Input, InputIcon } from '../../../components/Input';
import { Avatars } from '../../../types/Avatars';
import { Subjects } from '../../../types/Subjects';
import TeacherChat from './TeacherChat';
import { Container, List } from './TeacherList.elements';

const TeacherList: FC = () => {
  return (
    <Container>
      <Header3>Your teachers</Header3>
      <InputIcon>
        <AiOutlineSearch />
        <Input placeholder="Search" />
      </InputIcon>
      <List>
        <li className="item">
          <TeacherChat
            firstName="Bruno"
            lastName="Dzięcielski"
            avatarId={Avatars.male_1}
            _id="1"
            price={20}
            connected={[]}
            subjects={[
              Subjects.CHEMISTRY,
              Subjects.BIOLOGY,
              Subjects.ENGLISH,
              Subjects.FRENCH,
            ]}
          />
        </li>
        <li className="item">
          <TeacherChat
            firstName="Bruno"
            lastName="Dzięcielski"
            avatarId={Avatars.male_1}
            _id="1"
            price={20}
            connected={[]}
            subjects={[
              Subjects.CHEMISTRY,
              Subjects.BIOLOGY,
              Subjects.ENGLISH,
              Subjects.FRENCH,
            ]}
          />
        </li>
        <li className="item">
          <TeacherChat
            firstName="Bruno"
            lastName="Dzięcielski"
            avatarId={Avatars.male_1}
            _id="1"
            price={20}
            connected={[]}
            subjects={[
              Subjects.CHEMISTRY,
              Subjects.BIOLOGY,
              Subjects.ENGLISH,
              Subjects.FRENCH,
            ]}
          />
        </li>
        <li className="item">
          <TeacherChat
            firstName="Bruno"
            lastName="Dzięcielski"
            avatarId={Avatars.male_1}
            _id="1"
            price={20}
            connected={[]}
            subjects={[
              Subjects.CHEMISTRY,
              Subjects.BIOLOGY,
              Subjects.ENGLISH,
              Subjects.FRENCH,
            ]}
          />
        </li>
        <li className="item">
          <TeacherChat
            firstName="Bruno"
            lastName="Dzięcielski"
            avatarId={Avatars.male_1}
            _id="1"
            price={20}
            connected={[]}
            subjects={[
              Subjects.CHEMISTRY,
              Subjects.BIOLOGY,
              Subjects.ENGLISH,
              Subjects.FRENCH,
            ]}
          />
        </li>
      </List>
    </Container>
  );
};

export default TeacherList;
