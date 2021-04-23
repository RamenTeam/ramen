import { MigrationInterface, QueryRunner } from "typeorm";

export class UserAddConnection1619197635564 implements MigrationInterface {
	public async up(queryRunner: QueryRunner): Promise<void> {
		await queryRunner.query('ALTER TABLE "User" DROP COLUMN "email"');
		await queryRunner.query(
			'ALTER TABLE "User" ADD "email" character varying NULL'
		);
	}

	public async down(queryRunner: QueryRunner): Promise<void> {
		await queryRunner.query('ALTER TABLE "User" DROP COLUMN "email"');
		await queryRunner.query(
			'ALTER TABLE "User" ADD "email" character varying NOT NULL'
		);
	}
}
