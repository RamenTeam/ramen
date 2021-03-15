import { registerEnumType } from "type-graphql";

export enum UserRole {
	admin = "ADMIN",
	super_admin = "SUPER_ADMIN",
}

registerEnumType(UserRole, {
	name: "UserRole", // this one is mandatory
	description: "The role of user", // this one is optional
});
