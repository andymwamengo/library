import * as jwt from 'jsonwebtoken';
import { JwtPayload } from './jwt-payload';
import { ExecutionContext, HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { UserDto } from 'src/modules/users/dtos/users.dto';
import { LoginResponseDto } from '../dtos/login-response.dto';
import { TokenType } from 'src/shared/enums/token-type.enum';

@Injectable()
export class JWTService {
  // Load these from .env variable
  expireAt = '2d';
  secretKey = 'WSFSGHER#%HEDHNEDBN';

  constructor() { }

  public signJWTPayload(payload: UserDto): LoginResponseDto {
    const userPayload: JwtPayload = { id: payload.id, email: payload.email, role: payload.role };
    let _jwtToken: string = jwt.sign(userPayload, this.secretKey, { expiresIn: this.expireAt });
    let user: LoginResponseDto = new LoginResponseDto();
    user.accessToken = _jwtToken;
    user.user = payload;
    user.expireAt = this.expireAt;
    user.tokenType = TokenType.BEARER;
    return user
  }


  public userFromToken(context: ExecutionContext) {
    const request = context.switchToHttp().getRequest();
    if (!request || (request && !request.headers) ||
      (request && request.headers && !request.headers.authorization)) {
      return false;
    }
    const user = this.verifyJWTPayload(
      request && request.headers && request.headers.authorization
        ? request.headers.authorization : '');
    return user;
  }


  public verifyJWTPayload(authorization: string) {
    const splitAuthorization = (authorization || '').split(' ');
    if (splitAuthorization[0] !== 'Bearer') {
      throw new HttpException('Invalid Token', HttpStatus.FORBIDDEN);
    }
    const jwtToken = splitAuthorization[1];
    try {
      const currentUser: any = jwt.verify(jwtToken, this.secretKey);
      if (currentUser) {
        return currentUser;
      } else {
        throw new HttpException('Invalid User Token', HttpStatus.NOT_FOUND);
      }
    } catch (error) {
      throw new HttpException('Generic Error', HttpStatus.UNAUTHORIZED);
    }
  }
}