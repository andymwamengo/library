/**
 * Auth Service
 */
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { Observable } from 'rxjs';
import { shareReplay } from 'rxjs/operators';
import { Router } from '@angular/router';
import { LoginUser } from 'src/app/modules/models/login.model';
import { Users } from 'src/app/modules/models/user.model';
import { LoginResponse } from 'src/app/modules/models/login.response';

@Injectable({
  providedIn: 'root',
})
export class AuthService {

  constructor(private http: HttpClient, private router: Router) { }

  logIn(user: LoginUser): Observable<any> {
    const url = `${environment.apiUrl}/auth/login/`;
    return this.http.post<any>(url, user).pipe(shareReplay(1));
    // .subscribe((user: LoginResponse) => {
    //   localStorage.setItem('currentUser', (user.accessToken));
    //   this.router.navigate(['/users/account']);
    // });
  }

  setUserToken(user: LoginResponse): void {
    localStorage.setItem('currentUser', (user.accessToken));
  }

  signUpUser(user: Users): Observable<Users> {
    const url = `${environment.apiUrl}/auth/register/`;
    return this.http.post<Users>(url, user).pipe(shareReplay(1));
  }

  getStatus(): Observable<Users> {
    const url = `${environment.apiUrl}/auth/status/`;
    return this.http.get<Users>(url, { withCredentials: true }).pipe(shareReplay(1));
  }

  isUserLoggedIn(): Observable<boolean> {
    const url = `${environment.apiUrl}/auth/isLoggedIn/`;
    return this.http.get<boolean>(url, { withCredentials: true });
  }


  userLogout(): void {
    localStorage.removeItem('currentUser');
    this.router.navigate(["/auth/login"])
    window.location.reload(); 
  }

  getCurrentUser() {
    return localStorage.getItem("currentUser")
  }

}
