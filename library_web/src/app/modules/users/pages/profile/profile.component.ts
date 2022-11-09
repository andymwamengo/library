import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Observable, of, Subscription } from 'rxjs';
import { AuthService } from 'src/app/modules/auth/services/auth/auth.service';
import { BookService } from 'src/app/modules/books/services/book.service';
import { Books } from 'src/app/modules/models/books.model';
import { Users } from 'src/app/modules/models/user.model';
import { UserService } from '../../services/user.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss'],
})
export class ProfileComponent implements OnInit {
  subscription!: Subscription;
  accountSubscription!: Subscription;
  userId!: number;
  user$!: Observable<Users>;
  books$!: Observable<Books[]>;

  constructor(
    private activatedRouter: ActivatedRoute,
    private userService: UserService,
    private authService: AuthService,
    private bookService: BookService
  ) {}

  ngOnInit(): void {
    this.subscription = this.activatedRouter.paramMap.subscribe(
      (param: ParamMap) => {
        this.userId = +param.get('id')!;
        if (this.userId) {
          this.getUserById(this.userId);
        } else {
          this.getUserAccount();
        }
      }
    );
  }

  getUserById(id: number) {
    this.accountSubscription = this.userService.getById(id).subscribe((res) => {
      this.getUsersBooks(res.id!);
      this.user$ = of(res);
    });
  }

  getUserAccount() {
    this.user$ = this.authService.getStatus();
    this.getCurrentUsersBooks();
  }

  getUsersBooks(id: number) {
    this.books$ = this.bookService.getUserBooks(id);
  }

  getCurrentUsersBooks() {
    this.books$ = this.bookService.getCurrentUserBook();
  }

  ngOnDestroy() {
    if (this.subscription) {
      this.subscription.unsubscribe();
    }
    if (this.accountSubscription) {
      this.accountSubscription.unsubscribe();
    }
  }
}
