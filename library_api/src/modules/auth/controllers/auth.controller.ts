/**
 * Auth Controller
 */
import {
  Controller,
  UseGuards,
  Post,
  Body,
  Get,
  Req,
} from '@nestjs/common';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';
import { LoginDto } from '../dtos/login.dto';
import { LoginResponseDto } from '../dtos/login-response.dto';
import { CreateUserDto } from 'src/modules/users/dtos/user.create.dto';
import { UserDto } from 'src/modules/users/dtos/users.dto';
import { ReqUser } from '../interface/request.user';
import { AuthService } from '../services/auth.service';
import { JWTAuthGuard } from '../guards/jwt-auth.guard';
import { Request } from 'express';

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(
    private readonly authService: AuthService,
  ) { }

  @Post('register')
  async registerUser(@Body() createUserDto: CreateUserDto): Promise<any> {
    return await this.authService.register(createUserDto);
  }

  @Post('login')
  async loginUser(@Body() loginDto: LoginDto, @Req() req: Request): Promise<LoginResponseDto> {
    return await this.authService.login(loginDto);
  }

  @Get('status')
  @ApiBearerAuth()
  @UseGuards(JWTAuthGuard)
  async authenticate(@ReqUser() user): Promise<UserDto> {
    return await this.authService.getUserById(user.id);
  }

}

