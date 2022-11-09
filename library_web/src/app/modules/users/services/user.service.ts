import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { SnackbarService } from '../../../shared/services/snackbar/snackbar.service';
import { Users } from '../../models/user.model';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  
  constructor(private httpClient: HttpClient, private snackbarService: SnackbarService) { }

  create(user: Users): Observable<Users> {
    return this.httpClient.post<Users>(environment.apiUrl + '/users/', (user))
      .pipe(
        catchError(this.errorHandler)
      )
  }
  getById(id: number): Observable<Users> {
    return this.httpClient.get<Users>(environment.apiUrl + '/users/' + id)
      .pipe(
        catchError(this.errorHandler)
      )
  }

  getAll(): Observable<Users[]> {
    return this.httpClient.get<Users[]>(environment.apiUrl + '/users/')
      .pipe(
        catchError(this.errorHandler)
      )
  }

  update(id: number, user: Users): Observable<Users> {
    return this.httpClient.patch<Users>(environment.apiUrl + '/users/' + id, (user))
      .pipe(
        catchError(this.errorHandler)
      )
  }

  delete(id: number) {
    return this.httpClient.delete<Users>(environment.apiUrl + '/users/' + id)
      .pipe(
        catchError(this.errorHandler)
      )
  }
  errorHandler(error: any) {
    let errorMessage = '';
    if (error.error instanceof ErrorEvent) {
      errorMessage = error.error.message;
      this.snackbarService.openSnackBar(errorMessage, "OK")
    } else {
      errorMessage = `Error Code: ${error.status}\nMessage: ${error.message}`;
      this.snackbarService.openSnackBar(errorMessage, "OK")
    }
    return throwError(() => errorMessage);
  }
}