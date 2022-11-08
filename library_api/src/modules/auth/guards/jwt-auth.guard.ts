import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { JWTService } from '../jwt/jwt.service';

@Injectable()
export class JWTAuthGuard implements CanActivate {
  jwtService = new JWTService();
  constructor(){}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const _ctx = await this.jwtService.userFromToken(context);
    return !!_ctx;
  }
}
