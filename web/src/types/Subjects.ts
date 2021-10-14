import { OptionsOrGroups, GroupBase } from 'react-select';

export enum Subjects {
  MATH = 'math',
  CHEMISTRY = 'chemistry',
  PHYSICS = 'physics',
  POLISH = 'polish',
  ENGLISH = 'english',
  BIOLOGY = 'biology',
  FRENCH = 'french',
  INFORMATIC = 'informatic',
  SPANISH = 'spanish',
  GERMAN = 'german',
  HISTORY = 'history',
  GEOGRAPHIC = 'geographic',
}

export interface SubjectType {
  value: string;
  label: string;
}

export const SelectSubjects: OptionsOrGroups<SubjectType, GroupBase<any>> = [
  { value: Subjects.MATH, label: 'Math' },
  { value: Subjects.CHEMISTRY, label: 'Chemistry' },
  { value: Subjects.PHYSICS, label: 'Physics' },
  { value: Subjects.POLISH, label: 'Polish' },
  { value: Subjects.ENGLISH, label: 'English' },
  { value: Subjects.BIOLOGY, label: 'Biology' },
  { value: Subjects.FRENCH, label: 'French' },
  { value: Subjects.INFORMATIC, label: 'Informatic' },
  { value: Subjects.SPANISH, label: 'Spanish' },
  { value: Subjects.GERMAN, label: 'German' },
  { value: Subjects.HISTORY, label: 'History' },
  { value: Subjects.GEOGRAPHIC, label: 'Geographic' },
];
