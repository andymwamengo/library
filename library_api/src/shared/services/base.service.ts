import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { Repository, DeleteResult, DeepPartial, FindOptionsWhere } from 'typeorm';
import { QueryDeepPartialEntity } from 'typeorm/query-builder/QueryPartialEntity';

@Injectable()
export class BaseService<T> {

  constructor(private repository: Repository<T>) { }

  async find(): Promise<T[]> {
    const data = await this.repository.find();
    try {
      return data;
    } catch (error) {
      throw new HttpException(`Generic Error ${error}`, HttpStatus.BAD_REQUEST);
    }
  }

  async findOne(id: number): Promise<T> {
    const data = await this.repository.findOneBy({ id: id } as unknown as FindOptionsWhere<T>);
    if (!data) {
      throw new HttpException('Not Found', HttpStatus.NOT_FOUND);
    }
    try {
      return data;
    } catch (error) {
      throw new HttpException(`Generic Error ${error}`, HttpStatus.BAD_REQUEST);
    }
  }

  async create(T: DeepPartial<T>): Promise<DeepPartial<T>> {
    const data: any = await this.repository.create(T);
    try {
      return await this.repository.save(data);
    } catch (error) {
      throw new HttpException(`Generic Error ${error}`, HttpStatus.BAD_REQUEST);
    }
  }

  async update(id: number, data: QueryDeepPartialEntity<T>) {
    await this.repository.update(id, data);
    const dataResult = await this.findOne(id);
    try {
      return dataResult;
    } catch (error) {
      throw new HttpException(`Generic Error ${error}`, HttpStatus.BAD_REQUEST);
    }
  }

  async delete(id: number): Promise<DeleteResult> {
    let object: any = { isDeleted: true };
    const data = await this.repository.update(id, object);
    try {
      return data;
    } catch (error) {
      throw new HttpException(`Generic Error ${error}`, HttpStatus.BAD_REQUEST);
    }
  }

  async createMany(T: DeepPartial<T[]>): Promise<DeepPartial<T[]>> {
    for (let index = 0; index < T.length; index++) {
      const element = T[index];
      const data: any = await this.repository.create(element);
      try {
        await this.repository.save(data);
      } catch (error) {
        throw new HttpException(`Generic Error ${error}`, HttpStatus.BAD_REQUEST);
      }
    }
    throw new HttpException('Saved Data Successfully', HttpStatus.OK);

  }

  async updateMany(T: QueryDeepPartialEntity<T[]>) {
    for (let index = 0; index < T.length; index++) {
      const element: any = T[index];
      try {
        await this.repository.update(element.id, element);
      } catch (error) {
        throw new HttpException(`Generic Error ${error}`, HttpStatus.BAD_REQUEST);
      }
    }
    throw new HttpException('Updated Data Successfully', HttpStatus.OK);
  }
}