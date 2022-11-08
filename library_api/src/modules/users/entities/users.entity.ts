/**
 * User Entity
 */
import {
  Entity,
  Column,
  BeforeInsert,
  OneToMany,
  Index,
} from 'typeorm';

import { Base } from 'src/shared/entities/base/base.entity';
import { Exclude } from 'class-transformer';
import { Books } from 'src/modules/books/entities/books.entity';
import { UserRole } from 'src/shared/enums/roles.enums';


@Entity('users')
export class Users extends Base {
  @Column({ type: 'varchar', nullable: false, unique: true, length: 100 })
  @Index({ unique: true })
  username: string;

  @Column({ type: 'varchar', nullable: false, unique: true, length: 50 })
  @Index({ unique: true })
  email: string;

  @Column({ type: 'varchar', nullable: false })
  @Exclude()
  password: string;

  @Column({ type: 'varchar', enum: UserRole, default: UserRole.NORMAL })
  role: UserRole;

  /** One User can have many authors */
  @OneToMany(() => Books, (author: Books) => author.author, { cascade: true })
  books?: Books[];

  /** LowerCase Email Before Insert */
  @BeforeInsert()
  nameToUpperCase() {
    this.email = this.email.toLowerCase();
  }

}
