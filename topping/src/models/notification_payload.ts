import { Field, ObjectType } from "type-graphql";
import { User } from "../entity/User";
import { SubPayload } from "../utils/graphql-utils";
import ConnectionStatusType from "./connection_status_type";
import { NotificationType } from "./index";

@ObjectType("NotificationPayloadSchema")
export default class NotificationPayload extends SubPayload {
	@Field(() => NotificationType)
	type: NotificationType;

	@Field(() => User!)
	user: User;

	@Field(() => String!)
	label: string;

	@Field(() => String!)
	notificationId: string;
}
