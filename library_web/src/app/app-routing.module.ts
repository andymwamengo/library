import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [{ path: 'users', loadChildren: () => import('./modules/users/users.module').then(m => m.UsersModule) }, { path: 'auth', loadChildren: () => import('./modules/auth/auth.module').then(m => m.AuthModule) }, { path: 'books', loadChildren: () => import('./modules/books/books.module').then(m => m.BooksModule) }];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
