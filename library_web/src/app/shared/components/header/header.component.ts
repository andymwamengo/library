import { Component, OnInit } from '@angular/core';
import { Observable, of } from 'rxjs';
import { AuthService } from 'src/app/modules/auth/services/auth/auth.service';
import { BookService } from 'src/app/modules/books/services/book.service';
import { Books } from 'src/app/modules/models/books.model';
import { Users } from 'src/app/modules/models/user.model';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss']
})
export class HeaderComponent implements OnInit {
  currentUser$!: Observable<Users>;
  books$!: Observable<Books[]>;

  constructor(private authService: AuthService, private bookService: BookService) { }

  ngOnInit(): void {
    this.currentUser$ = this.authService.getStatus();
  }

  logout() {
    this.authService.userLogout();
  }

  searchBooks(event: Event) {
    //Adding propagations of routing whenever there is a search results
    let searchText = (event.target as HTMLInputElement).value;
    this.bookService.searchBooks(searchText).subscribe((_book) => {
      this.books$ = of(_book)
      // this.bookService.addBookSubject(_book);
    })

  }
}
