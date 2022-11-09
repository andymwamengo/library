import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { take } from 'rxjs';
import { LoginResponse } from 'src/app/modules/models/login.response';
import { AuthService } from '../../services/auth/auth.service';
import { SnackbarService } from '../../../../shared/services/snackbar/snackbar.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
  /** Variables */
  loginForm!: FormGroup;
  submitted = false;
  hide = true;
  isLoading!: boolean;

  constructor(
    private formBuilder: FormBuilder,
    private authService: AuthService,
    private router: Router,
    private snackbarService: SnackbarService
  ) { }

  ngOnInit(): void {
    this.loginForm = this.formBuilder.group({
      email: [
        '',
        [
          Validators.required,
          Validators.email,
          Validators.minLength(4),
          Validators.maxLength(50),
        ],
      ],
      password: ['', [Validators.required, Validators.minLength(4)]],
    });
    this.isLoading = false;
  }

  /** access to form fields */
  get f() {
    return this.loginForm.controls;
  }


  onSubmit(): void {
    this.submitted = true;
    this.isLoading = true;
    if (this.loginForm.invalid) {
      return;
    }
    this.isLoading = true;
    if (this.loginForm.valid) {
      const users = this.authService.logIn(this.loginForm.value).pipe(take(1));
      users.subscribe({
        next: (res: LoginResponse) => {
          this.authService.setUserToken(res);
          this.router.navigate(['/users']);
        },
        error: (error) => {
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