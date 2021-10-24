import { FC, useContext, useEffect, useState } from 'react';

import {
  CSSTransition,
  SwitchTransition,
  TransitionGroup,
} from 'react-transition-group';
import axios from 'axios';

import { Center } from '../../../components/Center';
import Teacher from './Teacher';
import { Img, List, NotFound, SubjectList } from './TeacherList.elements';
import '../../../styles/animations.css';
import { Header2 } from '../../../components/Header';
import { SUBJECTS } from '../../../contants';
import { loggedUserContext } from '../../../context/loggedUser';
import RatesPopup from '../../../components/Rate/RatesPopup';

const subjects: string[] = Object.values(SUBJECTS).map(subject => subject);

subjects.unshift('all');

const { REACT_APP_SERVER_URL } = process.env;

const TeacherList: FC<{ search: string }> = ({ search }) => {
  const { user, token } = useContext(loggedUserContext);

  const [active, setActive] = useState<typeof subjects>([]);
  const [teachers, setTeachers] = useState<UserType[]>([]);
  const [found, setFound] = useState(1);
  const [seeRates, setSeeRates] = useState(false);
  const [selectedTeacher, setSelectedTeacher] = useState('');

  useEffect(() => {
    setFound(1);
  }, [search]);

  useEffect(() => {
    user && setActive(user.subjects);

    axios.get<UserType[]>(`${REACT_APP_SERVER_URL}/users`).then(res => {
      if (token && res.data.length) {
        axios
          .get<UserType[]>(`${REACT_APP_SERVER_URL}/users/chatted`, {
            headers: {
              Authorization: token,
            },
          })
          .then(res1 => {
            const toSet = res.data.filter(teacher => {
              let isReturn = true;

              res1.data.forEach(teacher1 => {
                if (teacher._id === teacher1._id) isReturn = false;
              });

              return isReturn;
            });

            setTeachers(toSet);

            if (toSet.length) setFound(1);
          });
      }
    });
  }, [token, user]);

  useEffect(() => {
    selectedTeacher ? setSeeRates(true) : setSeeRates(false);
  }, [selectedTeacher]);

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

  const handleSeeRates = (id: string) => {
    setSelectedTeacher(id);
  };

  const renderTeachers = (): JSX.Element[] => {
    const tempTeachers =
      active[0] === 'all'
        ? teachers
        : teachers
            .filter(teacher => {
              let ret = false;
              teacher.subjects.forEach(subject => {
                active.forEach(act => {
                  if (act === subject) ret = true;
                });
              });

              return ret;
            })
            .filter(teacher => {
              return (
                teacher.firstName.toLowerCase() +
                ' ' +
                teacher.lastName.toLowerCase()
              ).includes(search.toLowerCase());
            });

    if (!tempTeachers[0] && found) setFound(0);
    else if (tempTeachers[0] && !found) setFound(1);

    const deleteFromList = (id: string) => {
      setTeachers(prev => prev.filter(teacher => teacher._id !== id));
    };

    return tempTeachers.map(teacher => {
      return (
        <CSSTransition key={teacher._id} timeout={200} classNames="slide">
          <li>
            <Teacher
              {...teacher}
              deleteFromList={deleteFromList}
              seeRates={handleSeeRates}
            />
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

                <Img src="/images/hero_no_results.svg" alt="No teacher found" />
              </NotFound>
            )}
          </CSSTransition>
        </SwitchTransition>
      </Center>
      <CSSTransition
        in={seeRates}
        timeout={200}
        classNames="fade-fast"
        unmountOnExit
      >
        <RatesPopup
          teacherId={selectedTeacher}
          close={() => setSelectedTeacher('')}
        />
      </CSSTransition>
    </div>
  );
};

export default TeacherList;
