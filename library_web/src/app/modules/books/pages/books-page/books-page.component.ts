import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { Books } from 'src/app/modules/models/books.model';
import { BookService } from '../../services/book.service';

@Component({
  selector: 'app-books-page',
  templateUrl: './books-page.component.html',
  styleUrls: ['./books-page.component.scss']
})
export class BooksPageComponent implements OnInit {
  books$!: Observable<Books[]>
  totalBooks!: Observable<number>;

  constructor(private bookService:BookService) { }

  ngOnInit(): void {
    this.books$ = this.bookService.getAll();
    this.totalBooks = this.bookService.booksTotal(1);
    
    // this.books$ = this.bookService.getBookSubject();
  }

}
