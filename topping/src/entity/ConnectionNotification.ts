import { Field, ObjectType } from "type-graphql";
import { ChildEntity, Column, JoinColumn, ManyToOne, OneToOne } from "typeorm";
import ConnectionStatusType from "../models/connection_status_type";
import Notification from "./Notification";
import { User } from "./User";

@ObjectType("ConnectionNotificationSchema")
@ChildEntity("ConnectionNotification")
export class ConnectionNotification extends Notification {
	@Field(() => User!)
	@ManyToOne(() => User, (user) => user.connectionNotificationSent, {
		nullable: true,
	})
	from: User;

	@Field(() => ConnectionStatusType!)
	@Column("text", { nullable: false, default: ConnectionStatusType.PENDING })
	status: ConnectionStatusType;
}
