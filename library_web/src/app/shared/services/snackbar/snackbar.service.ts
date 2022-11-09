/**
 * Data Flow Service
 */
import { Injectable } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';

@Injectable({
  providedIn: 'root',
})
export class SnackbarService {

  constructor(public snackBar: MatSnackBar) { }

  openSnackBar(message: string, action: string) {
    return this.snackBar.open(message, action, {
      duration: 3000,
      verticalPosition: 'bottom',
      panelClass: 'snackbar-message',
    });
  }

}
