import { FC } from 'react';

import styled from '@emotion/styled';

import { Avatar } from '../../../components/Avatar';
import { Button } from '../../../components/Button';
import { Header3 } from '../../../components/Header';
import { TeacherType } from '../../../types/Teacher';
import {
  Container,
  SubjectList,
} from '../../teachers/components/Teacher.elements';

const StyledSubjectList = styled(SubjectList)`
  li {
    margin: 0;
  }
`;

const TeacherChat: FC<TeacherType> = ({
  avatarId,
  firstName,
  lastName,
  price,
  subjects,
}) => {
  const renderSubjects = (): JSX.Element[] => {
    return subjects.map(subject => {
      return (
        <li key={subject}>
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
      <StyledSubjectList>{renderSubjects()}</StyledSubjectList>

      <Header3 style={{ marginTop: '1rem' }}>{price}$ / h</Header3>
      <Button style={{ width: '100%', margin: '1rem 0' }}>Chat</Button>
      <Button style={{ width: '100%' }} secondary>
        Revoke
      </Button>
    </Container>
  );
};

export default TeacherChat;
