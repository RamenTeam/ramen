import { Field, ID, ObjectType } from "type-graphql";
import {
	BaseEntity,
	BeforeInsert,
	Column,
	Entity,
	ManyToOne,
	PrimaryColumn,
} from "typeorm";
import { User } from "./User";
import { v4 as uuidv4 } from "uuid";
import { Conversation } from "./Conversation";

@ObjectType("MessageSchema")
@Entity("Message")
export class Message extends BaseEntity {
	@Field(() => ID)
	@PrimaryColumn("uuid")
	id: String;

	@Field(() => User!, { nullable: true })
	@ManyToOne(() => User, { onDelete: "CASCADE" })
	sender: User;

	@Field(() => String!)
	@Column("text", { nullable: false })
	message: String;

	@Field(() => Boolean!)
	@Column("bool", { nullable: false, default: false })
	unread: Boolean;

	@Field(() => String!)
	@Column("text", { nullable: false, default: new Date().toISOString() })
	createdAt: String;

	@ManyToOne(() => Conversation, (conversation) => conversation.messages, {
		onDelete: "CASCADE",
	})
	conversation: Conversation;

	@BeforeInsert()
	async addId() {
		this.id = uuidv4();
	}
}
