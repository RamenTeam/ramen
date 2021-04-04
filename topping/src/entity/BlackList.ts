import { Field, ID, ObjectType } from "type-graphql";
import { BaseEntity, Column, Entity, PrimaryColumn } from "typeorm";

//TODO Add Phone Number to black list
@ObjectType("BlackListSchema")
@Entity("BlackList")
export class BlackList extends BaseEntity {
	@Field(() => ID)
	@PrimaryColumn("uuid")
	id: string;

	@Field(() => String!)
	@Column("text", { unique: true })
	phoneNumber: string;
}
