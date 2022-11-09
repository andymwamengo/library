import { Component, Input, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { AuthService } from 'src/app/modules/auth/services/auth/auth.service';
import { Books } from 'src/app/modules/models/books.model';
import { Users } from 'src/app/modules/models/user.model';
import { BookService } from '../../services/book.service';

@Component({
  selector: 'app-book',
  templateUrl: './book.component.html',
  styleUrls: ['./book.component.scss']
})
export class BookComponent implements OnInit {
  @Input() book!: Books;
  @Input() totalBooks!: number;
  currentUser$!: Observable<Users>; 

  constructor(private authService: AuthService, private bookService: BookService) { }

  ngOnInit(): void {
    this.currentUser$ = this.authService.getStatus();
  }

  deleteBook(book: Books){
    if(window.confirm(`Confirm to Delete  a Book with title ${book.title}`)){
      this.bookService.delete(book.id!).subscribe();
    }
  }
}
