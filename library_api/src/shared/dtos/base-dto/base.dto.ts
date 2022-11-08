import { ApiProperty } from "@nestjs/swagger";

export class BaseDto {
  @ApiProperty()
  id?: number;

  @ApiProperty()
  createdAt?: Date;

  @ApiProperty()
  updatedAt?: Date;

  @ApiProperty()
  deletedAt?: Date;

  @ApiProperty()
  isActive?: boolean;

  @ApiProperty()
  isDeleted?: boolean;
  
  @ApiProperty()
  createdBy?: String;

  @ApiProperty()
  updatedBy?: string;

  @ApiProperty()
  deletetBy?: string;
}
