import { registerEnumType } from "type-graphql";

enum ConnectionStatusType {
	PENDING = "PENDING",
	ACCEPTED = "ACCEPTED",
	REJECTED = "REJECTED",
}

registerEnumType(ConnectionStatusType, {
	name: "ConnectionStatusType",
	valuesConfig: {
		PENDING: {
			description: "PENDING",
		},
		ACCEPTED: {
			description: "ACCEPTED",
		},
		REJECTED: {
			description: "REJECTED",
		},
	},
});

export default ConnectionStatusType;
