import { Component, OnDestroy, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, ParamMap, Router } from '@angular/router';
import { Subscription, take } from 'rxjs';
import { PasswordValidator } from 'src/app/shared/validators/password';
import { AuthService } from '../../services/auth/auth.service';
import { SnackbarService } from '../../../../shared/services/snackbar/snackbar.service';
import { UserService } from 'src/app/modules/users/services/user.service';
import { Users } from 'src/app/modules/models/user.model';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit, OnDestroy {
  signUpForm!: FormGroup;
  submitted = false;
  hide = true;
  isLoading!: boolean;
  subscription!: Subscription;
  userId!: number;

  constructor(
    private formBuilder: FormBuilder,
    private authService: AuthService,
    private usersService: UserService,
    private router: Router,
    private snackbarService: SnackbarService,
    private activatedRouter: ActivatedRoute,
  ) { }

  ngOnInit(): void {
    this.isLoading = false;
    this.subscription = this.activatedRouter.paramMap.subscribe((param: ParamMap) => {
      this.userId = +param.get('id')!;
      if (this.userId) {
        this.getUserById(this.userId);
      } else {
        this.generateForm(undefined);
      }
    });
  }

  generateForm(user?: Users) {
    this.signUpForm = this.formBuilder.group({
      username: [user?.username, [Validators.required, Validators.minLength(4)]],
      email: [
        user?.email,
        [
          Validators.required,
          Validators.email,
          Validators.minLength(4),
          Validators.maxLength(50),
        ],
      ],
      password: ['', [Validators.required, Validators.minLength(4)]],
      confirmPassword: ['', [Validators.required, Validators.minLength(4)]],
      validator: [PasswordValidator.confirmed('password', 'confirmPassword')],
    });
  }


  getUserById(userId: number) {
    this.usersService.getById(this.userId).subscribe((res) => {
      return this.generateForm(res);
    });
  }

  get f() {
    return this.signUpForm.controls;
  }


  onSubmit(): void {
    this.submitted = true;
    this.isLoading = true;
    if (this.signUpForm.invalid) {
      return;
    }
    this.isLoading = true;
    if (this.signUpForm.valid) {
      let userForm: Users = {
        username: this.signUpForm.value.username,
        email: this.signUpForm.value.email,
        password: this.signUpForm.value.password,
      }
      if (this.userId) {
        userForm.id = this.userId;
        const users = this.usersService.update(this.userId, userForm).pipe(take(1));
        users.subscribe({
          next: (res: any) => {
            this.router.navigate(['/users/profile']);
          },
          error: (error: { error: string }) => {
            if (error.error !== undefined) {
              this.snackbarService.openSnackBar(error.error, "OK");
            }
            this.isLoading = false;
          },
          complete: () => { }
        }
        );
      } else {
        const users = this.authService.signUpUser(userForm).pipe(take(1));
        users.subscribe({
          next: (res: any) => {
            this.router.navigate(['/auth/login']);
          },
          error: (error: { error: string }) => {
            if (error.error !== undefined) {
              this.snackbarService.openSnackBar(error.error, "OK");
            }
            this.isLoading = false;
          },
          complete: () => { }
        }
        );
      }
    }
  }

  ngOnDestroy(): void {
    if (this.subscription) {
      this.subscription.unsubscribe();
    }
  }

}