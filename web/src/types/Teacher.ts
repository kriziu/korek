import { Avatars } from './Avatars';
import { Subjects } from './Subjects';

export interface TeacherType {
  firstName: string;
  lastName: string;
  price: number;
  avatarId: Avatars;
  subjects: Subjects[];
  connected: { _id: string; subject: string }[];
}
