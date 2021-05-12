import { createUnionType } from "type-graphql";
import { ConnectionNotification } from "../entity/ConnectionNotification";
import Notification from "../entity/Notification";

const NotificationUnionType = createUnionType({
	name: "NotificationUnion",
	types: () => [ConnectionNotification, Notification] as const,
	resolveType: (value) => {
		if ("from" in value || "to" in value || "status" in value) {
			return ConnectionNotification;
		}
		return Notification;
	},
});

export default NotificationUnionType;
