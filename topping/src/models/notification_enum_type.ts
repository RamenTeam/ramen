import { registerEnumType } from "type-graphql";

enum NotificationType {
	NEW_CONNECTION = "NEW_CONNECTION",
}

registerEnumType(NotificationType, {
	name: "Type of Notification",
	description: "Type for each specific notification",
	valuesConfig: {
		NEW_CONNECTION: {
			description:
				"Whenever there's a connection between user-user, this is triggered",
		},
	},
});

export default NotificationType;
