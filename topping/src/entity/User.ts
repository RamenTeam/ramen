import { Field, ID, ObjectType, Root } from "type-graphql";
import {
	Entity,
	Column,
	PrimaryColumn,
	BeforeInsert,
	BaseEntity,
	ManyToMany,
	RelationCount,
	JoinTable,
	OneToMany,
	JoinColumn,
} from "typeorm";
import { v4 as uuidv4 } from "uuid";
import * as bcrypt from "bcrypt";
import { UserStatus } from "../shared/UserStatus.enum";
import { DEFAULT_AVATAR_PATH } from "../constants/global-variables";
import { ConnectionNotification } from "./ConnectionNotification";
import Notification from "./Notification";
import { Conversation } from "./Conversation";

@ObjectType("UserSchema")
@Entity("User")
export class User extends BaseEntity {
	@Field(() => ID)
	@PrimaryColumn("uuid")
	id: string;

	@Field(() => String!)
	@Column("varchar", { unique: true })
	email: string;

	@Field(() => String!)
	@Column("varchar", { unique: true, length: 30 })
	username: string;

	@Field(() => String, { simple: true })
	@Column("text", {
		default: DEFAULT_AVATAR_PATH,
	})
	avatarPath: string;

	@Field(() => Boolean!)
	@Column("bool", { default: true })
	isVerified: boolean;

	@Field(() => Boolean!)
	@Column("bool", { default: false })
	isBanned: boolean;

	@Field(() => Boolean!)
	@Column("bool", { default: false })
	forgotPasswordLock: boolean;

	@Field(() => String)
	@Column("varchar", { default: "", length: 150 })
	bio: string;

	@Field(() => String!)
	@Column("varchar", { unique: true, length: 25 })
	phoneNumber: string;

	// @Authorized(UserRole.super_admin)
	@Field(() => String!, { simple: true })
	@Column()
	password: string;

	@Field(() => String!, { simple: true })
	@Column({ nullable: true })
	firstName: string;

	@Field(() => String!)
	@Column({ nullable: true })
	lastName: string;

	@Field(() => UserStatus!, { simple: true })
	@Column("text", { nullable: true, default: UserStatus.none })
	status: UserStatus;

	@Field(() => [User])
	@ManyToMany((type) => User, (user) => user.connections)
	@JoinTable()
	connections: User[];

	@Field(() => [Conversation])
	@ManyToMany(() => Conversation, (conversation) => conversation.participants, {
		onDelete: "CASCADE",
	})
	@JoinColumn()
	conversations: Conversation[];

	@Field(() => Number!, { simple: true })
	@RelationCount((user: User) => user.conversations)
	conversationsCount: number;

	// FIXME deprecated
	@Field(() => Number!, { simple: true })
	@RelationCount((user: User) => user.connections)
	connectionsCount: number;

	@OneToMany(() => ConnectionNotification, (conn) => conn.from)
	connectionNotificationSent: ConnectionNotification[];

	@OneToMany(() => Notification, (conn) => conn.to)
	connectionNotificationReceived: Notification[];

	// External
	@Field(() => String!, { simple: true })
	name(@Root() parent: User): string {
		return `${parent.firstName} ${parent.lastName}`;
	}

	@BeforeInsert()
	async addId() {
		this.id = uuidv4();
	}

	@BeforeInsert()
	async hashPassword() {
		this.password = await bcrypt.hash(this.password, 10);
	}
}
