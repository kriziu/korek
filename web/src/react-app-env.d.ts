/// <reference types="react-scripts" />

enum Avatars {
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
  avatarId: Avatars;
  userType: 'teacher' | 'student';
  subjects: Subjects[];
}
