import { Component, OnInit } from '@angular/core';
import { RouterService } from './shared/services/router/router.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit {
  title = 'library_web';
  logo = "assets/library.png"
  constructor(private routerService: RouterService){}

  ngOnInit(){}


  hasRoute(route: string) {
    return this.routerService.matchRoute(route);
  }}
