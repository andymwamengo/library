import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { UsersService } from 'src/modules/users/services/users.service';
import { BaseService } from 'src/shared/services/base.service';
import { ILike, Like, Repository } from 'typeorm';
import { BooksDto } from '../dtos/books.dto';
import { Books } from '../entities/books.entity';

@Injectable()
export class BooksService extends BaseService<Books> {
  bookRepository: Repository<Books>;

  constructor(
    @InjectRepository(Books) repository: Repository<Books>,
    private readonly usersService: UsersService,
  ) {
    super(repository);
    this.bookRepository = repository;
  }

  async find() {
    return await this.bookRepository.find({
      where: {
        public: true,
      },
    });
  }

  async searchBook(searchText: string) {
    let data = await this.bookRepository.find({
      where: {
        title: Like(`%${searchText}%`),
        public: true,
        // description: ILike(`%${searchText}%`)
      },
    });
    return data;
  }

  async createOneBook(userId: number, bookDto: BooksDto) {
    let _user = await this.usersService.findOne(userId);
    let book = this.bookRepository.create({
      ...bookDto,
      author: _user,
    });
    return await this.bookRepository.save(book);
  }

  async createManyBooks(userId: number, bookDto: BooksDto[]) {
    for (const bookItem of bookDto) {
      await this.createOneBook(userId, bookItem);
    }
  }

  async getBookById(id: number) {
    let book = await this.bookRepository.findOne({
      where: {
        public: true,
      },
    });
    return book;
  }

  async getBookByAuthor(id: number): Promise<Books[]> {
    let book = await this.bookRepository.find({
      where: {
        author: {
          id: id,
        },
        public: true,
      },
    });
    return book;
  }

  async getBookByAuthorPrivate(id: number): Promise<Books[]> {
    let book = await this.bookRepository.find({
      where: {
        author: {
          id: id,
        },
      },
    });
    return book;
  }

  async getTotalBookAuthor(id: number): Promise<number> {
    let book = await this.bookRepository.count({
      where: {
        author: {
          id: id,
        },
      },
    });
    return book;
  }

  async updateOneBook(userId: number, id: number, bookDto: BooksDto) {
    let book = await this.bookRepository.findOne({
      where: {
        id: bookDto.id,
      },
    });
    if (userId === book.author.id) {
      let _book = this.bookRepository.create({
        ...bookDto,
        author: book.author,
      });
      return await this.bookRepository.update(book.id, _book);
    } else {
      throw new HttpException(
        'Forbidden to Perform Update Action',
        HttpStatus.FORBIDDEN,
      );
    }
  }

  async updateManyBooks(userId: number, ids: number[], bookDto: BooksDto[]) {
    for (const bookItem of bookDto) {
      for (const bookId of ids) {
        await this.updateOneBook(userId, bookId, bookItem);
      }
    }
  }

  async deleteOneBook(userId: number, id: number) {
    let book = await this.bookRepository.findOne({
      where: {
        id: id,
      },
    });
    if (userId === book.author.id) {
      return await this.bookRepository.delete(book.id);
    } else {
      throw new HttpException(
        'Forbidden to Perform Delete Action',
        HttpStatus.FORBIDDEN,
      );
    }
  }

  async deleteManyBooks(userId: number, ids: number[]) {
    for (const bookId of ids) {
      await this.deleteOneBook(userId, bookId);
    }
  }
}
