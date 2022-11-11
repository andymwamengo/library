import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { Users } from 'src/app/modules/models/user.model';
import { UserService } from '../../services/user.service';

@Component({
  selector: 'app-users-page',
  templateUrl: './users-page.component.html',
  styleUrls: ['./users-page.component.scss']
})
export class UsersPageComponent implements OnInit {
  users$!: Observable<Users[]>;

  constructor(private usersService: UserService) { }

  ngOnInit(): void {
    this.users$ = this.usersService.getAll();
  }

}
