import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { CreateUserDto } from 'src/modules/users/dtos/user.create.dto';
import { UserDto } from 'src/modules/users/dtos/users.dto';
import { UsersService } from 'src/modules/users/services/users.service';
import { comparePassword, hashPassword } from 'src/shared/password/password';
import { LoginResponseDto } from '../dtos/login-response.dto';
import { LoginDto } from '../dtos/login.dto';
import { JWTService } from '../jwt/jwt.service';

@Injectable()
export class AuthService {

  constructor(private readonly userService: UsersService,
    private readonly jwtService: JWTService) { }

  public async register(createUserDto: CreateUserDto) {
    const _user = await this.userService.findByEmail(createUserDto.email);
    if (_user) {
      throw new HttpException('The Email Already Exist', HttpStatus.BAD_GATEWAY);
    } else {
      const password = await hashPassword(createUserDto.password)
      const user = await this.userService.create({ ...createUserDto, password: password });
      user.password = undefined;
      return user;
    }
  }

  public async login(userDto: LoginDto): Promise<LoginResponseDto> {
    const user = await this.userService.findByEmail(userDto.email);
    const isPasswordMatching = await comparePassword(userDto.password, user.password);
    if (!isPasswordMatching) {
      throw new HttpException('Invalid credentials provided', HttpStatus.BAD_REQUEST);
    }
    try {
      const currentUser: UserDto = user;
      const userToken = this.jwtService.signJWTPayload(currentUser);
      return userToken
    } catch (error) {
      throw new HttpException('Generic Error', HttpStatus.BAD_REQUEST);
    }
  }

  public getUserById(id: number): Promise<UserDto> {
    return this.userService.findOne(id)
  }

}
