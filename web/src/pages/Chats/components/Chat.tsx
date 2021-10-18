import { FC } from 'react';
import { Avatar } from '../../../components/Avatar';
import { Button } from '../../../components/Button';
import { Header3 } from '../../../components/Header';
import { StudentType } from '../../../types/Student';
import { TeacherType } from '../../../types/Teacher';
import { Top } from './Chat.elements';

const Chat: FC<TeacherType | StudentType> = ({
  firstName,
  lastName,
  _id,
  avatarId,
}) => {
  return (
    <div>
      <Top>
        <Avatar id={avatarId} />
        <Header3 style={{ marginLeft: '1rem' }}>
          {firstName} {lastName}
        </Header3>
        <Button>Enter room</Button>
        <Button secondary>Pay</Button>
      </Top>
    </div>
  );
};

export default Chat;
