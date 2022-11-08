/**
 * Auth Module
 * @implements Passport JWT, Google Auth2
 */

import { Module } from '@nestjs/common';
import { UsersModule } from '../users/users.module';
import { AuthController } from './controllers/auth.controller';
import { JWTService } from './jwt/jwt.service';
import { AuthService } from './services/auth.service';

@Module({
  imports: [
    UsersModule,
  ],
  controllers: [
    AuthController,
  ],
  providers: [
    AuthService,
    JWTService,
  ],
  exports: [
    AuthService,
    JWTService,
  ],
})
export class AuthModule {}
