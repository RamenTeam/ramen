import { Arg, Resolver, Query, UseMiddleware } from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import { Conversation } from "../../../../entity/Conversation";
import { ConversationUnion } from "../../../../models/conversation_union_type";
import { yupValidateMiddleware } from "../../../middleware/yupValidate";
import { ConversationRepository } from "../../../repository/ConversationRepository";
import { DirectConversationRepository } from "../../../repository/DirectConversationRepository";
import {
	GetConversationDto,
	YUP_CONVERSATION_READ,
} from "./get_conversation.dto";

@Resolver((of) => Conversation)
class GetConversationResolver {
	@InjectRepository(ConversationRepository)
	private readonly directConversationRepository: DirectConversationRepository;

	@UseMiddleware(yupValidateMiddleware(YUP_CONVERSATION_READ))
	@Query(() => ConversationUnion, { nullable: true })
	async getConversation(@Arg("data") { conversationId }: GetConversationDto) {
		const directConversation =
			await this.directConversationRepository.findOneByIdWithRelations(
				conversationId
			);

		return directConversation;
	}
}

export default GetConversationResolver;
