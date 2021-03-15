import { registerEnumType } from "type-graphql";

export enum GroupConversationVisibility {
	public = "public",
	private = "private",
}

registerEnumType(GroupConversationVisibility, {
	name: "GroupConversationVisibility", // this one is mandatory
	description: "The visibility mode of the group conversation", // this one is optional
});
