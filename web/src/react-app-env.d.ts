/// <reference types="react-scripts" />
import { SUBJECTS, AVATARS } from './contants';

declare global {
  interface MessageType {
    roomId: string;
    from: string;
    message: string;
  }

  interface SubjectType {
    value: string;
    label: string;
  }

  interface UserType {
    _id: string;
    firstName: string;
    lastName: string;
    email: string;
    price: number;
    avatarId: AVATARS;
    userType: 'teacher' | 'student';
    subjects: SUBJECTS[];
  }
}
