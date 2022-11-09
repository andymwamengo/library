import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { BooksRoutingModule } from './books-routing.module';
import { BooksComponent } from './books.component';
import { BookComponent } from './components/book/book.component';
import { CreateBookComponent } from './components/create-book/create-book.component';
import { BookDetailComponent } from './pages/book-detail/book-detail.component';
import { BooksPageComponent } from './pages/books-page/books-page.component';
import { MaterialModule } from '../material/material.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { SnackbarService } from 'src/app/shared/services/snackbar/snackbar.service';

export const components = [
  BookComponent,
  CreateBookComponent,
  BookDetailComponent,
  BooksPageComponent
]
@NgModule({
  declarations: [
    BooksComponent,
    components,
  ],
  imports: [
    CommonModule,
    BooksRoutingModule,
    MaterialModule,
    FormsModule,
    ReactiveFormsModule,
    MatSnackBarModule,
  ],
  exports: [
    components,
  ],
  providers: [
    SnackbarService,
  ]
})
export class BooksModule { }
