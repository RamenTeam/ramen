import { Field, ID, ObjectType } from "type-graphql";
import { v4 as uuidv4 } from "uuid";
import {
	BaseEntity,
	BeforeInsert,
	Column,
	Entity,
	ManyToOne,
	PrimaryColumn,
	TableInheritance,
} from "typeorm";
import { User } from "./User";

@Entity("Notification")
@ObjectType("NotificationSchema")
@TableInheritance({ column: { type: "varchar", name: "type" } })
class Notification extends BaseEntity {
	@Field(() => ID)
	@PrimaryColumn("uuid")
	id: string;

	@Field(() => User!)
	@ManyToOne(() => User, (user) => user.connectionNotificationReceived, {
		nullable: true,
	})
	to: User;

	@Field(() => Boolean!, { simple: true })
	@Column("bool", { default: false })
	read: boolean;

	@Field(() => String!, { simple: true })
	@Column("text")
	label: string;

	@Field(() => String, { simple: true })
	@Column("text", { default: new Date().toISOString() })
	createdAt?: string;

	@BeforeInsert()
	async addId() {
		this.id = uuidv4();
	}
}

export default Notification;
