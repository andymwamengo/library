
import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { JWTService } from '../jwt/jwt.service';

let jwtService = new JWTService();

export const ReqUser = createParamDecorator(
  (data: string, ctx: ExecutionContext) => {
    let _user = jwtService.userFromToken(ctx);
    return _user;
  },
);
