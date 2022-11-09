import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { ThemePalette } from '@angular/material/core';
import { ActivatedRoute, ParamMap, Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { Books } from 'src/app/modules/models/books.model';
import { BookService } from '../../services/book.service';

@Component({
  selector: 'app-create-book',
  templateUrl: './create-book.component.html',
  styleUrls: ['./create-book.component.scss']
})
export class CreateBookComponent implements OnInit {
  bookForm!: FormGroup;
  subscription!: Subscription;
  bookId!: number;
  color: ThemePalette = 'primary';


  constructor(
    public fb: FormBuilder,
    private router: Router,
    private activatedRouter: ActivatedRoute,
    public bookService: BookService
  ) { }



  ngOnInit() {
    this.subscription = this.activatedRouter.paramMap.subscribe((param: ParamMap) => {
      this.bookId = +param.get('id')!;
      if (this.bookId) {
        this.getUserById(this.bookId);
      } else {
        this.generateForm(undefined);
      }
    });
  }

  getUserById(bookId: number) {
    this.bookService.getById(this.bookId).subscribe((res) => {
      return this.generateForm(res);
    });
  }
  generateForm(book?: Books): void {
    this.bookForm = this.fb.group({
      title: [book?.title, [Validators.required, Validators.minLength(5), Validators.maxLength(50)]],
      description: [book?.description, [Validators.required, Validators.minLength(50), Validators.maxLength(200)]],
      public: [book?.public, []]
    })
  }


  submitForm() {
    this.bookForm.value?.public === null ? this.bookForm.value.public === false : true;
    if (this.bookId) {
      this.bookService.update(this.bookId, this.bookForm.value).subscribe((res) => {
        this.router.navigate(['/books']);
      })
    }else {
      this.bookService.create(this.bookForm.value).subscribe((res) => {
        this.router.navigate(['/books']);
      });
    }
  }

}