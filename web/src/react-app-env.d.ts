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
    rate: number;
    wallet: number;
    avatarId: AVATARS;
    userType: 'teacher' | 'student';
    subjects: SUBJECTS[];
  }

  interface RateType {
    teacherId: string;
    from: UserType;
    stars: number;
    message: string;
  }

  interface LoginType {
    token: string;
    error?: string;
  }
}
