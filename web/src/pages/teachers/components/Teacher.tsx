import { FC } from 'react';

import { AiFillStar } from 'react-icons/ai';

import { Avatar } from '../../../components/Avatar';
import { Button } from '../../../components/Button';
import { Header3 } from '../../../components/Header';
import { Container, Rating, SubjectList } from './Teacher.elements';
import { TeacherType } from '../../../types/Teacher';

const Teacher: FC<TeacherType> = ({
  firstName,
  lastName,
  price,
  subjects,
  avatarId,
}) => {
  // DODAC CENE
  // DODAC POPOVER

  const renderSubjects = (): JSX.Element[] => {
    return subjects.map((subject, index) => {
      return (
        <li key={index}>
          {subject[0].toUpperCase()}
          {subject.slice(1)}
        </li>
      );
    });
  };

  return (
    <Container>
      <Avatar id={avatarId} />
      <Header3 style={{ marginTop: '1rem', maxWidth: '18rem' }}>
        {firstName} {lastName}
      </Header3>
      <SubjectList>{renderSubjects()}</SubjectList>
      <Rating>
        <AiFillStar />
        <Header3>4.7</Header3>
      </Rating>
      <Button style={{ width: '100%' }}>Choose</Button>
    </Container>
  );
};

export default Teacher;
