import { Avatars } from './Avatars';
import { Subjects } from './Subjects';

export interface TeacherType {
  _id: string;
  firstName: string;
  lastName: string;
  price: number;
  avatarId: Avatars;
  subjects: Subjects[];
  connected: { _id: string; subject: string }[];
}
