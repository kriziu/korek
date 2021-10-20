import { FC, useEffect, useState } from 'react';

import {
  CSSTransition,
  SwitchTransition,
  TransitionGroup,
} from 'react-transition-group';
import axios from 'axios';

import { Center } from '../../../components/Center';
import Teacher from './Teacher';
import { List, NotFound, SubjectList } from './TeacherList.elements';
import '../../../styles/animations.css';
import { Header2 } from '../../../components/Header';
import { SUBJECTS } from '../../../contants';

const subjects: string[] = Object.values(SUBJECTS).map(subject => subject);

subjects.unshift('all');

const { REACT_APP_SERVER_URL } = process.env;

const TeacherList: FC = () => {
  const [active, setActive] = useState<typeof subjects>(['all']);
  const [teachers, setTeachers] = useState<UserType[]>([]);
  const [found, setFound] = useState(1);

  useEffect(() => {
    axios.get<UserType[]>(`${REACT_APP_SERVER_URL}/users`).then(res => {
      setTeachers(res.data);
      setFound(1);
    });
  }, []);

  const handleActiveClick = (subject: string) => {
    setFound(1);

    if (subject === 'all') {
      setActive(['all']);
      return;
    }

    let tempR = false;
    active.forEach(act => {
      if (act === subject) tempR = true;
    });
    if (tempR) {
      const preActive = active.filter(e => e !== subject);
      if (!preActive.length) {
        setActive(['all']);
        return;
      }
      setActive(prev => prev.filter(e => e !== subject));
      return;
    }

    setActive(prev => [...prev, subject].filter(e => e !== 'all'));
  };

  const renderSubjects = (active: string[]): JSX.Element[] => {
    return subjects.map(subject => {
      let tempAct = false;
      active.forEach(act => {
        if (subject === act) tempAct = true;
      });

      return (
        <li
          key={subject}
          className={tempAct ? 'active' : ''}
          onClick={() => handleActiveClick(subject)}
        >
          {subject[0].toUpperCase()}
          {subject.slice(1)}
        </li>
      );
    });
  };

  const renderTeachers = (): JSX.Element[] => {
    const tempTeachers =
      active[0] === 'all'
        ? teachers
        : teachers.filter(teacher => {
            let ret = false;
            teacher.subjects.forEach(subject => {
              active.forEach(act => {
                if (act === subject) ret = true;
              });
            });

            return ret;
          });

    console.log(tempTeachers);
    console.log(teachers);

    if (!tempTeachers[0] && found) setFound(0);
    else if (tempTeachers[0] && !found) setFound(1);

    return tempTeachers.map(teacher => {
      return (
        <CSSTransition key={teacher._id} timeout={200} classNames="slide">
          <li>
            <Teacher {...teacher} />
          </li>
        </CSSTransition>
      );
    });
  };

  return (
    <div>
      <SubjectList>{renderSubjects(active)}</SubjectList>

      <Center>
        <SwitchTransition mode="out-in">
          <CSSTransition timeout={200} classNames="fade-fast" key={found}>
            {found ? (
              <List>
                <TransitionGroup component={null}>
                  {renderTeachers()}
                </TransitionGroup>
              </List>
            ) : (
              <NotFound>
                <Header2>No teacher found</Header2>

                <img src="/images/hero_no_results.svg" alt="No teacher found" />
              </NotFound>
            )}
          </CSSTransition>
        </SwitchTransition>
      </Center>
      <Center></Center>
    </div>
  );
};

export default TeacherList;
