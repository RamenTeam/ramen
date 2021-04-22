import { Field, ID, ObjectType } from "type-graphql";
import { v4 as uuidv4 } from "uuid";
import {
	BaseEntity,
	BeforeInsert,
	Column,
	Entity,
	PrimaryColumn,
	TableInheritance,
} from "typeorm";

@Entity("Notification")
@ObjectType("NotificationSchema")
@TableInheritance({ column: { type: "varchar", name: "type" } })
class Notification extends BaseEntity {
	@Field(() => ID)
	@PrimaryColumn("uuid")
	id: string;

	@Field(() => Boolean!)
	@Column("bool", { default: false })
	read: boolean;

	@Field(() => String!)
	@Column("text")
	label: string;

	@Field(() => String)
	@Column("text", { default: new Date().toISOString() })
	createdAt?: string;

	@BeforeInsert()
	async addId() {
		this.id = uuidv4();
	}
}

export default Notification;
