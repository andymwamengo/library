import { Injectable } from '@angular/core';
import { Event, RouterEvent, Router } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class RouterService {

  constructor(private router: Router) { }

  matchRoute(route: string) {
    return this.router.url.includes(route);
  }

  matchExactRoute(route: string) {
    if (this.router.url.length === route.length) {
      return true;
    } else {
      return null;
    }
  }

}
