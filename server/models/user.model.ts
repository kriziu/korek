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

export enum Avatars {
  female_1 = 'female_1',
  female_2 = 'female_2',
  female_3 = 'female_3',
  female_4 = 'female_4',
  female_5 = 'female_5',
  female_6 = 'female_6',
  male_1 = 'male_1',
  male_2 = 'male_2',
  male_3 = 'male_3',
  male_4 = 'male_4',
  male_5 = 'male_5',
  male_6 = 'male_6',
}

export interface UserType {
  firstName: string;
  lastName: string;
  email: string;
  password: string;
  price: number;
  avatarId: Avatars;
  userType: 'teacher' | 'student';
  subjects: Subjects[];
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
  price: {
    type: Number,
    required: true,
  },
  avatarId: {
    type: String,
    enum: Avatars,
    required: true,
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
});

export type StudentModelType =
  | (Document<any, any, UserType> &
      UserType & {
        _id: Types.ObjectId;
      })
  | null
  | undefined;

export default mongoose.model<UserType>('User', userSchema);
