import { EntityRepository } from "typeorm";
import { DirectConversation } from "../../entity/DirectConversation";
import { ConversationRepository } from "./ConversationRepository";

@EntityRepository(DirectConversation)
export class DirectConversationRepository extends ConversationRepository<DirectConversation> {
	constructor() {
		super();
	}

	async findOneByIdWithRelations(conversationId) {
		return await DirectConversation.findOne({
			relations: ["participants", "messages", "messages.sender"],
			where: {
				id: conversationId,
			},
		});
	}
}
