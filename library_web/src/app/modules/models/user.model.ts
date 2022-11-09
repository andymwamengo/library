/**
 * User Model
 */
import { Books } from './books.model';

export interface Users {
  id?: number;
  username: string;
  email: string;
  password?: string;
  role?: string;
  verified?: boolean;
  isActive?: boolean;
  isDeleted?: boolean;
  updatedAt?: string;
  createdAt?: string;
  books?: Books[];
}
