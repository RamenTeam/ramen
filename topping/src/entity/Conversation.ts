import { Field, ID, ObjectType } from "type-graphql";
import {
	BaseEntity,
	BeforeInsert,
	Column,
	Entity,
	JoinTable,
	ManyToMany,
	OneToMany,
	PrimaryColumn,
	TableInheritance,
} from "typeorm";
import { User } from "./User";
import { v4 as uuidv4 } from "uuid";
import { Message } from "./Message";

@ObjectType("ConversationSchema")
@Entity("Conversation")
@TableInheritance({ column: { type: "varchar", name: "type" } })
export abstract class Conversation extends BaseEntity {
	@Field(() => ID)
	@PrimaryColumn("uuid")
	id: string;

	@Field(() => String!)
	@Column("text", { nullable: false, default: new Date().toISOString() })
	createdAt: string;

	@Field(() => [User!])
	@ManyToMany(() => User, (user) => user.conversations, { onDelete: "CASCADE" })
	@JoinTable()
	participants: User[];

	@Field(() => [Message!])
	@OneToMany(() => Message, (msg) => msg.conversation)
	messages: Message[];

	@BeforeInsert()
	async addId() {
		this.id = uuidv4();
	}
}
