import { FC, useEffect, useState } from 'react';

import axios from 'axios';

import { Center } from '../../../components/Center';
import { Subjects } from '../../../types/Subjects';
import Teacher from './Teacher';
import { List, Pages, SubjectList } from './TeacherList.elements';
import { TeacherType } from '../../../types/Teacher';

const subjects: string[] = Object.values(Subjects).map(subject => subject);

subjects.unshift('all');

const { REACT_APP_SERVER_URL } = process.env;

const TeacherList: FC = () => {
  const [active, setActive] = useState('all');
  const [teachers, setTeachers] = useState<TeacherType[]>([]);

  useEffect(() => {
    axios.get<TeacherType[]>(`${REACT_APP_SERVER_URL}/users`).then(res => {
      setTeachers(res.data);
    });
  }, []);

  const renderSubjects = (active: string): JSX.Element[] => {
    return subjects.map(subject => {
      return (
        <li
          key={subject}
          className={subject === active ? 'active' : ''}
          onClick={() => setActive(subject)}
        >
          {subject[0].toUpperCase()}
          {subject.slice(1)}
        </li>
      );
    });
  };

  const renderTeachers = (): JSX.Element[] => {
    return teachers.map(teacher => {
      return (
        <li key={teacher._id}>
          <Teacher {...teacher} />
        </li>
      );
    });
  };

  return (
    <div>
      <SubjectList>{renderSubjects(active)}</SubjectList>
      <Center>
        <List>{renderTeachers()}</List>
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
