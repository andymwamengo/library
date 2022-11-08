/**
 * Roles Decorators
 */
import { SetMetadata } from '@nestjs/common';
import { UserRole } from '../enums/roles.enums';

export const UserRoles = (...roles: UserRole[]) => SetMetadata('roles', roles);
