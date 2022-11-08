import { Injectable } from '@nestjs/common';
import { APIResponse } from './shared/constants';

@Injectable()
export class AppService {

  getAPIResponse() {
    return APIResponse
  }
}
