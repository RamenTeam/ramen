import { createUnionType } from "type-graphql";
import { DirectConversation } from "../entity/DirectConversation";

export const ConversationUnion = createUnionType({
	name: "ConversationUnion",
	types: () => [DirectConversation] as const,
	resolveType: (value) => {
		return DirectConversation;
	},
});
