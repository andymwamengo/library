import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError, BehaviorSubject } from 'rxjs';
import { environment } from 'src/environments/environment';
import { SnackbarService } from '../../../shared/services/snackbar/snackbar.service';
import { Books } from '../../models/books.model';

@Injectable({
  providedIn: 'root'
})
export class BookService {

  private books: BehaviorSubject<any> = new BehaviorSubject(null);

  constructor(private httpClient: HttpClient, public snackbarService: SnackbarService) { }

  create(book: Books): Observable<Books> {
    return this.httpClient.post<Books>(environment.apiUrl + '/books/', book)
      .pipe(catchError(this.errorHandler))
  }
  getById(id: number): Observable<Books> {
    return this.httpClient.get<Books>(environment.apiUrl + '/books/' + id)
      .pipe(catchError(this.errorHandler))
  }

  getAll(): Observable<Books[]> {
    return this.httpClient.get<Books[]>(environment.apiUrl + '/books/')
      .pipe(catchError(this.errorHandler))
  }

  getUserBooks(id: number): Observable<Books[]> {
    return this.httpClient.get<Books[]>(`${environment.apiUrl}/books/author/` + id)
      .pipe(catchError(this.errorHandler))
  }

  getCurrentUserBook(): Observable<Books[]> {
    return this.httpClient.get<Books[]>(`${environment.apiUrl}/books/page/data`)
      .pipe(catchError(this.errorHandler))
  }

  addBookSubject(books: Books[]): void {
    this.books.next(books);
  }

  getBookSubject(): Observable<Books[]> {
    return this.books.asObservable();
  }

  searchBooks(search: string): Observable<Books[]> {
    return this.httpClient.get<Books[]>(environment.apiUrl + '/books/search/' + search)
      .pipe(catchError(this.errorHandler))
  }

  booksTotal(id: number): Observable<number> {
    return this.httpClient.get<number>(environment.apiUrl + '/books/author/' + id)
      .pipe(catchError(this.errorHandler))
  }

  update(id: number, book: Books): Observable<Books> {
    return this.httpClient.patch<Books>(environment.apiUrl + '/books/' + id, book)
      .pipe(catchError(this.errorHandler))
  }

  delete(id: number) {
    return this.httpClient.delete<Books>(environment.apiUrl + '/books/' + id)
      .pipe(catchError(this.errorHandler))
  }
  errorHandler(error: any) {
    let errorMessage = '';
    if (error.error instanceof ErrorEvent) {
      errorMessage = error.message;
      if (errorMessage) {
        this.snackbarService.openSnackBar(errorMessage, "OK")
      }
    } else {
      errorMessage = `Error Code: ${error.status}\nMessage: ${error.message}`;
      if (errorMessage) {
        this.snackbarService.openSnackBar(errorMessage!, "OK")
        window.alert(errorMessage)
      }
    }
    return throwError(() => errorMessage);
  }
}