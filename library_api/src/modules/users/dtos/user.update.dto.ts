/**
 * User DTO
 */
import { ApiProperty } from '@nestjs/swagger';
import { Exclude } from 'class-transformer';
import { IsNotEmpty } from 'class-validator';
import { BaseDto } from 'src/shared/dtos/base-dto/base.dto';

export class UpdateUserDto extends BaseDto {
  @ApiProperty()
  @IsNotEmpty()
  username?: string;

  @ApiProperty()
  @IsNotEmpty()
  email?: string;

  @ApiProperty()
  @Exclude()
  password?: string;

}
