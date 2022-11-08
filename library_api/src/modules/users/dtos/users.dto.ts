/**
 * User DTO
 */
import { ApiProperty } from '@nestjs/swagger';
import { Exclude } from 'class-transformer';
import { IsNotEmpty } from 'class-validator';
import { BaseDto } from 'src/shared/dtos/base-dto/base.dto';
import { UserRole } from 'src/shared/enums/roles.enums';

export class UserDto extends BaseDto {
  @ApiProperty()
  @IsNotEmpty()
  username?: string;

  @ApiProperty()
  @IsNotEmpty()
  email?: string;

  @ApiProperty({
    enum: UserRole,
  })
  @Exclude()
  role?: UserRole;
}
