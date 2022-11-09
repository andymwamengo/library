import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { BooksComponent } from './books.component';
import { CreateBookComponent } from './components/create-book/create-book.component';
import { BookDetailComponent } from './pages/book-detail/book-detail.component';
import { BooksPageComponent } from './pages/books-page/books-page.component';


const routes: Routes = [{
  path: '', component: BooksComponent,
  children: [
    {
      path: "books",
      component: BooksPageComponent,
    },
    {
      path: "details/:id",
      component: BookDetailComponent,
    },
    {
      path: "create",
      component: CreateBookComponent,
    },
    {
      path: "create/:id",
      component: CreateBookComponent,
    },
    {
      path: "",
      pathMatch: "full",
      redirectTo: "books"
    }
  ]
}];


@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class BooksRoutingModule { }
