/**
 * Question Entity
 **/
import {
  Entity,
  Column,
  ManyToOne,
} from 'typeorm'; 
import { Base } from 'src/shared/entities/base/base.entity';
import { Users } from 'src/modules/users/entities/users.entity';

@Entity('books')
export class Books extends Base {
  @Column({ type: 'varchar', nullable: false, unique: true })
  title: string;

  @Column({ type: 'varchar', nullable: false, length: 200 })
  description: string;

  @Column({ type: 'boolean', default: true, nullable: false })
  public: boolean;

  @ManyToOne(() => Users, (user: Users) => user.books, { eager: true })
  author: Users;

}
