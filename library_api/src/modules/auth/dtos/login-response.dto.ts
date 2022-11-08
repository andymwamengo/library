/**
 * User DTO
 */
import { ApiProperty } from '@nestjs/swagger';
import { Exclude } from 'class-transformer';
import { UserDto } from 'src/modules/users/dtos/users.dto';
import { UserRole } from 'src/shared/enums/roles.enums';
import { TokenType } from 'src/shared/enums/token-type.enum';

export class LoginResponseDto {
  @ApiProperty()
  user: UserDto

  @ApiProperty()
  accessToken: string;

  @ApiProperty()
  expireAt?: string;

  @ApiProperty()
  tokenType?: TokenType;

  @ApiProperty()
  message?: string;

}
