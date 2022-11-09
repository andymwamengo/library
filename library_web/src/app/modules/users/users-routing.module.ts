import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ProfileComponent } from './pages/profile/profile.component';
import { UsersPageComponent } from './pages/users-page/users-page.component';
import { UsersComponent } from './users.component';

const routes: Routes = [{
  path: '', component: UsersComponent,
  children: [
    {
      path: "accounts",
      component: UsersPageComponent,
    },
    {
      path: "profile",
      component: ProfileComponent,
    },
    {
      path: "profile/:id",
      component: ProfileComponent,
    },
    {
      path: "",
      pathMatch: "full",
      redirectTo: "accounts"
    }
  ]
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class UsersRoutingModule { }
