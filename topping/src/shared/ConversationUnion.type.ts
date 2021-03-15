import { createUnionType } from "type-graphql";
import { DirectConversation } from "../entity/DirectConversation";
import { GroupConversation } from "../entity/GroupConversation";

export const ConversationUnion = createUnionType({
	name: "ConversationUnion",
	types: () => [GroupConversation, DirectConversation] as const,
	resolveType: (value) => {
		if ("visibility" in value || "owner" in value || "name" in value) {
			return GroupConversation;
		}
		return DirectConversation;
	},
});
