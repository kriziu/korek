import { FC, useState } from 'react';
import { Center } from '../../../components/Center';
import { Avatars } from '../../../types/Avatars';
import { Subjects } from '../../../types/Subjects';
import Teacher from './Teacher';
import { List, Pages, SubjectList } from './TeacherList.elements';

const subjects: string[] = Object.values(Subjects).map(subject => subject);

subjects.unshift('all');

const TeacherList: FC = () => {
  const [active, setActive] = useState('all');

  const renderSubjects = (active: string): JSX.Element[] => {
    return subjects.map((subject, index) => {
      return (
        <li
          key={index}
          className={subject === active ? 'active' : ''}
          onClick={() => setActive(subject)}
        >
          {subject[0].toUpperCase()}
          {subject.slice(1)}
        </li>
      );
    });
  };

  return (
    <div>
      <SubjectList>{renderSubjects(active)}</SubjectList>
      <Center>
        <List>
          <li>
            <Teacher
              firstName="Bruno"
              lastName="Dzięcielski"
              price={20}
              avatarId={Avatars.male_1}
              subjects={[Subjects.BIOLOGY, Subjects.CHEMISTRY]}
              connected={[]}
            />
          </li>
        </List>
      </Center>
      <Center>
        <Pages>
          <button>Prev</button>|<button>Next</button>
        </Pages>
      </Center>
    </div>
  );
};

export default TeacherList;
