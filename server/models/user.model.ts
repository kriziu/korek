import mongoose, { Document, Types } from 'mongoose';

export enum Subjects {
  MATH = 'math',
  CHEMISTRY = 'chemistry',
  PHYSICS = 'physics',
  ENGLISH = 'english',
  BIOLOGY = 'biology',
  FRENCH = 'french',
  INFORMATIC = 'informatic',
  SPANISH = 'spanish',
  GERMAN = 'german',
  HISTORY = 'history',
  GEOGRAPHIC = 'geographic',
  POLISH = 'polish',
}

export interface UserType {
  firstName: string;
  lastName: string;
  email: string;
  password: string;
  userType: 'teacher' | 'student';
  subjects: Subjects[];
  connected: { _id: string; subject: string }[];
}

const userSchema = new mongoose.Schema<UserType>({
  firstName: {
    type: String,
    required: true,
  },
  lastName: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
    select: false,
  },
  subjects: [
    {
      type: String,
      enum: Subjects,
      required: true,
    },
  ],
  userType: {
    type: String,
    enum: ['teacher', 'student'],
    required: true,
  },
  connected: [
    {
      _id: {
        type: String,
        required: true,
      },
      subject: {
        type: String,
        enum: Subjects,
        required: true,
      },
    },
  ],
});

export type StudentModelType =
  | (Document<any, any, UserType> &
      UserType & {
        _id: Types.ObjectId;
      })
  | null
  | undefined;

export default mongoose.model<UserType>('User', userSchema);
