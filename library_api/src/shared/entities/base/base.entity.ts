import { Column, CreateDateColumn, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";

export class Base {
  @PrimaryGeneratedColumn()
  id: number;

  @CreateDateColumn({ type: 'timestamptz', nullable: false })
  createdAt?: Date;

  @UpdateDateColumn({ type: 'timestamptz', default: null, nullable: true })
  updatedAt?: Date;

  @CreateDateColumn({ type: 'timestamptz', default: null, nullable: true })
  deletedAt?: Date;

  @Column({ type: 'boolean', default: true, nullable: false })
  isActive?: boolean;

  @Column({ type: 'boolean', default: false, nullable: false })
  isDeleted?: boolean;

  @Column({ type: 'varchar', nullable: true, length: 50 })
  createdBy?: String;

}
