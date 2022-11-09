import { Users } from "./user.model";

export class LoginResponse {
  user!: Users
  accessToken!: string;
  expireAt?: string;
  tokenType?: TokenType;
  message?: string;

}

export enum TokenType {
  BEARER = 'Bearer',
  TWO_FACTOR = 'TwoFactor',
}
