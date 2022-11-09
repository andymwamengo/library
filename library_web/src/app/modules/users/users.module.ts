import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { UsersRoutingModule } from './users-routing.module';
import { UsersComponent } from './users.component';
import { MaterialModule } from '../material/material.module';
import { UserComponent } from './components/user/user.component';
import { ProfileComponent } from './pages/profile/profile.component';
import { UsersPageComponent } from './pages/users-page/users-page.component';
import { BooksModule } from '../books/books.module';


@NgModule({
  declarations: [
    UsersComponent,
    UserComponent,
    ProfileComponent,
    UsersPageComponent
  ],
  imports: [
    CommonModule,
    UsersRoutingModule,
    MaterialModule,
    BooksModule,
  ]
})
export class UsersModule { }
