import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { BaseService } from 'src/shared/services/base.service';
import { Repository } from 'typeorm';
import { UserDto } from '../dtos/users.dto';
import { Users } from '../entities/users.entity';

@Injectable()
export class UsersService extends BaseService<Users> {
  userRepository: Repository<Users>;

  constructor(
    @InjectRepository(Users) repository: Repository<Users>,
    // private readonly UsersService: UsersService,
  ) {
    super(repository);
    this.userRepository = repository;
  }

  async findByEmail(email: string): Promise<Users> {
    return await this.userRepository.findOne({ where: { email: email } })
  }
}
