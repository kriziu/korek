import { Avatars } from './Avatars';

export interface StudentType {
  _id: string;
  firstName: string;
  lastName: string;
  avatarId: Avatars;
  connected: { _id: string }[];
}
