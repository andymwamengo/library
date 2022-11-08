/**
 * Create User DTO
 */

import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsNotEmpty } from 'class-validator';

export class CreateUserDto {
  @ApiProperty()
  @IsNotEmpty()
  username?: string;

  @ApiProperty()
  @IsEmail()
  @IsNotEmpty()
  email?: string;

  @ApiProperty()
  @IsNotEmpty()
  password?: string;
}
