import { Field, ID, ObjectType } from "type-graphql";
import { v4 as uuidv4 } from "uuid";
import {
	BaseEntity,
	BeforeInsert,
	Column,
	Entity,
	PrimaryColumn,
} from "typeorm";
import { boolean } from "yup/lib/locale";

@Entity("Notification")
@ObjectType("NotificationSchema")
class Notification extends BaseEntity {
	@Field(() => ID)
	@PrimaryColumn("uuid")
	id: string;

	@Field(() => boolean!)
	@Column("bool", { default: false })
	read?: boolean;

	@Field(() => String!)
	@Column("text")
	label: string;

	@Field(() => String)
	@Column("string", { default: new Date().toISOString() })
	createdAt?: string;

	@BeforeInsert()
	async addId() {
		this.id = uuidv4();
	}
}

export default Notification;
