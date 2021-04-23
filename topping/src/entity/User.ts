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
} from "typeorm";
import { v4 as uuidv4 } from "uuid";
import * as bcrypt from "bcrypt";
import { UserStatus } from "../shared/UserStatus.enum";
import { DEFAULT_AVATAR_PATH } from "../constants/global-variables";

@ObjectType("UserSchema")
@Entity("User")
export class User extends BaseEntity {
	@Field(() => ID)
	@PrimaryColumn("uuid")
	id: string;

	@Field(() => String!)
	@Column("varchar", { unique: true, nullable: true })
	email: string;

	@Field(() => String!)
	@Column("varchar", { unique: true, length: 30 })
	username: string;

	@Field(() => String)
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
	@Field(() => String!)
	@Column()
	password: string;

	@Field(() => String!)
	@Column({ nullable: true })
	firstName: string;

	@Field(() => String!)
	@Column({ nullable: true })
	lastName: string;

	@Field(() => UserStatus!)
	@Column("text", { nullable: true, default: UserStatus.none })
	status: UserStatus;

	@Field(() => [User])
	@ManyToMany((type) => User, (user) => user.connections)
	@JoinTable()
	connections: User[];

	// FIXME deprecated
	@Field(() => Number!)
	@RelationCount((user: User) => user.connections)
	connectionsCount: number;

	// External
	@Field(() => String!)
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
