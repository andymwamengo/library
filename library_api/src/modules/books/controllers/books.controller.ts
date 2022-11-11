import { Body, Controller, Delete, Get, Param, Patch, Post, UseGuards } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { JWTAuthGuard } from 'src/modules/auth/guards/jwt-auth.guard';
import { ReqUser } from 'src/modules/auth/interface/request.user';
import { BooksDto } from '../dtos/books.dto';
import { Books } from '../entities/books.entity';
import { BooksService } from '../services/books.service';

@ApiTags('books')
@Controller('books')
export class BooksController {

  constructor(private readonly booksService: BooksService) { }

  @Post('')
  @UseGuards(JWTAuthGuard)
  async create(@Body() createBookDto: BooksDto, @ReqUser() user, ) {
    return await this.booksService.createOneBook(user.id, createBookDto);
  }

  @Post('many')
  @UseGuards(JWTAuthGuard)
  async createMany(@Body() createBookDto: BooksDto[], @ReqUser() user, ) {
    return await this.booksService.createManyBooks(user.id, createBookDto);
  }

  @Get('')
  async findAll() {
    return await this.booksService.find();
  }

  @Get('search/:search')
  async searchBooks(@Param('search') searchText: string) {
    return await this.booksService.searchBook(searchText);
  }

  @Get(':id')
  async findOne(@Param('id') id: number) {
    return await this.booksService.findOne(id);
  }

  @Patch(':id')
  @UseGuards(JWTAuthGuard)
  async update(@ReqUser() user, @Param('id') id: number, @Body() updateUserDto: Books) {
    return await this.booksService.updateOneBook(user.id, id, updateUserDto);
  }

  @Delete(':id')
  @UseGuards(JWTAuthGuard)
  async remove(@ReqUser() user, @Param('id') id: number) {
    return await this.booksService.deleteOneBook(user.id, id);
  }

  @Patch(':id')
  @UseGuards(JWTAuthGuard)
  async updateMany(@ReqUser() user, @Param('id') id: number[], @Body() updateUserDto: BooksDto[]) {
    return await this.booksService.updateManyBooks(user.id, id, updateUserDto);
  }

  @Delete(':id')
  @UseGuards(JWTAuthGuard)
  async removeMany(@ReqUser() user, @Param('id') id: number[]) {
    return await this.booksService.deleteManyBooks(user.id, id);
  }

  @Get('author/:id')
  async findBookByAuthor(@Param('id') id: number) {
    return await this.booksService.getBookByAuthor(id);
  }

  @Get('author')
  async findTotalCurrentUserBook(@ReqUser() user) {
    return await this.booksService.getTotalBookAuthor(user.id);
  }

  @Get('page/data')
  async bookProfile(@ReqUser() user) {
    return await this.booksService.getBookByAuthorPrivate(user.id);
  }
}
