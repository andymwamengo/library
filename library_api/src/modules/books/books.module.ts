/**
 * Books Module
 */
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UsersModule } from '../users/users.module';
import { BooksController } from './controllers/books.controller';
import { Books } from './entities/books.entity';
import { BooksService } from './services/books.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      Books,
    ]),
    UsersModule,
  ],
  providers: [
    BooksService,
  ],
  controllers: [
    BooksController,
  ],
  exports: [
    BooksService,
  ],
})
export class BooksModule {}
