import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { hashPassword } from 'src/shared/password/password';
import { BaseService } from 'src/shared/services/base.service';
import { Repository } from 'typeorm';
import { UserDto } from '../dtos/users.dto';
import { Users } from '../entities/users.entity';

@Injectable()
export class UsersService extends BaseService<Users> {
  userRepository: Repository<Users>;

  constructor(
    @InjectRepository(Users) repository: Repository<Users>,
  ) {
    super(repository);
    this.userRepository = repository;
  }

  async findByEmail(email: string): Promise<Users> {
    return await this.userRepository.findOne({ where: { email: email } })
  }

  async findOne(id: number) {
    let data = await this.userRepository.findOne({
      where: {
        id: id
      }
    })
    return data
  }


  async update(id: number, data: Users) {
    data.password = await hashPassword(data.password);
    await this.userRepository.update(id, data);
    return await this.findOne(id);
  }
  

}
