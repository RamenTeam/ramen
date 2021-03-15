import { registerEnumType } from "type-graphql";

export enum UserStatus {
	online = "online",
	offline = "offline",
	busy = "busy",
	none = "none",
	silence = "silence",
}

registerEnumType(UserStatus, {
	name: "UserStatus", // this one is mandatory
	description: "The activity status of user", // this one is optional
});
