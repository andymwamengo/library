import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Observable, Subscription } from 'rxjs';
import { Books } from 'src/app/modules/models/books.model';
import { BookService } from '../../services/book.service';

@Component({
  selector: 'app-book-detail',
  templateUrl: './book-detail.component.html',
  styleUrls: ['./book-detail.component.scss']
})
export class BookDetailComponent implements OnInit {
  subscription!: Subscription;
  book$!: Observable<Books>;
  bookId!: number;

  constructor(private activatedRouter: ActivatedRoute, private bookService: BookService) { }

  ngOnInit(): void {
    this.subscription = this.activatedRouter.paramMap.subscribe((param: ParamMap) => {
      this.bookId = +param.get('id')!;
      if (this.bookId) {
        this.getUserById(this.bookId);
      }
    });
  }

  getUserById(id: number) {
    this.book$ = this.bookService.getById(id);
  }

  ngOnDestroy() {
    if (this.subscription) {
      this.subscription.unsubscribe();
    }
  }


}
