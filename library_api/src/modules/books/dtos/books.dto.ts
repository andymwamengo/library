/**
 * Question Entity
 **/
 import { Base } from 'src/shared/entities/base/base.entity';
import { Users } from 'src/modules/users/entities/users.entity';
import { BaseDto } from 'src/shared/dtos/base-dto/base.dto';
import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, MaxLength } from 'class-validator';

export class BooksDto extends BaseDto {
  @ApiProperty()
  @IsNotEmpty()
  @MaxLength(50)
  title: string;

  @ApiProperty()
  @IsNotEmpty()
  @MaxLength(200)
  description: string;

  @ApiProperty()
  public?: boolean;

  @ApiProperty()
  author?: Users;

}
