import { Field, ObjectType } from "type-graphql";
import { ChildEntity, Column, JoinColumn, OneToOne } from "typeorm";
import ConnectionStatusType from "../models/connection_status_type";
import Notification from "./Notification";
import { User } from "./User";

@ObjectType("ConnectionNotificationSchema")
@ChildEntity("ConnectionNotification")
export class ConnectionNotification extends Notification {
	@Field(() => String!)
	@OneToOne((type) => User)
	@JoinColumn()
	from: string;

	@Field(() => String!)
	@OneToOne((type) => User)
	@JoinColumn()
	to: string;

	@Field(() => ConnectionStatusType!)
	@Column("text", { nullable: false, default: ConnectionStatusType.PENDING })
	status: ConnectionStatusType;
}
