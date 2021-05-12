import { Resolver, Query } from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import { Conversation } from "../../../../entity/Conversation";
import { ConversationUnion } from "../../../../models/conversation_union_type";
import { ConversationRepository } from "../../../repository/ConversationRepository";
import { DirectConversationRepository } from "../../../repository/DirectConversationRepository";

@Resolver((of) => Conversation)
class GetConversationsResolvers {
	@InjectRepository(ConversationRepository)
	private readonly directConversationRepository: DirectConversationRepository;

	@Query(() => [ConversationUnion]!)
	async getConversations() {
		const directConversations = await this.directConversationRepository.find({
			relations: ["participants", "messages", "messages.sender"],
		});

		console.log(directConversations);

		return [...directConversations];
	}
}

export default GetConversationsResolvers;
