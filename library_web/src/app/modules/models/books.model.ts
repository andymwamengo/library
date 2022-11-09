/**
 * Books Model
 */
import { Users } from './user.model';

export interface Books {
  id?: number;
  title: string;
  description: string;
  public?: boolean;
  isActive?: boolean;
  isDeleted?: boolean;
  createdAt?: string;
  updatedAt?: string;
  author?: Users;
}
