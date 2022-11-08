import * as bcrypt from 'bcrypt';

export const comparePassword = async (password: string, hashedPassword: string ): Promise<boolean> => {
  return await bcrypt.compare(password, hashedPassword);
}

export const hashPassword = async (password: string): Promise<string> =>  {
  return await bcrypt.hash(password, 10);
}