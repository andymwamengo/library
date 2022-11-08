import { Body, Controller, Delete, Get, Param, Patch, Post, UseGuards } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { JWTAuthGuard } from 'src/modules/auth/guards/jwt-auth.guard';
import { ReqUser } from 'src/modules/auth/interface/request.user';
import { UserRoles } from 'src/shared/decorators/roles.decorator';
import { UserRole } from 'src/shared/enums/roles.enums';
import { Users } from '../entities/users.entity';
import { UsersService } from '../services/users.service';

@ApiTags('users')
@Controller('users')
export class UsersController {

  constructor(private readonly usersService: UsersService) { }

  @Post('')  
  @UseGuards(JWTAuthGuard)
  @UserRoles(UserRole.ADMIN)
  async create(@Body() createUserDto: Users) {
    return await this.usersService.create(createUserDto);
  }

  @Post('many')
  @UseGuards(JWTAuthGuard)
  @UserRoles(UserRole.ADMIN)
  async createMany(@Body() createUserDto: Users[]) {
    return await this.usersService.createMany(createUserDto);
  }

  @Get('')
  async findAll() {
    return await this.usersService.find();
  }

  @Get(':id')
  async findOne(@Param('id') id: number) {
    return await this.usersService.findOne(id);
  }

  @Patch(':id')
  @UseGuards(JWTAuthGuard)
  async update(@ReqUser() user, @Body() updateUserDto: Users) {
    return await this.usersService.update(user.id, updateUserDto);
  }

  @Delete(':id')
  @UseGuards(JWTAuthGuard)
  async remove(@ReqUser() user,) {
    return await this.usersService.delete(user.id);
  }
}
