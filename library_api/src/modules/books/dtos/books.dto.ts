/**
 * Question Entity
 **/
 import { Base } from 'src/shared/entities/base/base.entity';
import { Users } from 'src/modules/users/entities/users.entity';
import { BaseDto } from 'src/shared/dtos/base-dto/base.dto';
import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty } from 'class-validator';

export class BooksDto extends BaseDto {
  @ApiProperty()
  @IsNotEmpty()
  title: string;

  @ApiProperty()
  @IsNotEmpty()
  description: string;

  @ApiProperty()
  @IsNotEmpty()
  public?: boolean;

  @ApiProperty()
  author?: Users;

}
