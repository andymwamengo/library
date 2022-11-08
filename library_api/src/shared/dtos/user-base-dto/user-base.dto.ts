import { ApiProperty } from '@nestjs/swagger';
import { BaseDto } from '../base-dto/base.dto';

export class UserBaseDto  extends BaseDto{
  @ApiProperty()
  createdBy?: String;

  @ApiProperty()
  updatedBy?: string;

  @ApiProperty()
  deletetBy?: string;
}
