import { EntityRepository, Repository } from "typeorm";
import { Conversation } from "../../entity/Conversation";
import { Message } from "../../entity/Message";
import { User } from "../../entity/User";

@EntityRepository(Conversation)
export class ConversationRepository<T> extends Repository<T> {
	async findConversationAndUpdateMessage(
		conversation: Conversation,
		chatMessage: Message
	) {
		if (conversation.messages) {
			conversation.messages.push(chatMessage);
		} else {
			const chats: Message[] = [];
			chats.push(chatMessage);
			conversation.messages = chats;
		}
	}

	async findConversationAndUpdateParticipant(
		conversation: Conversation,
		user: User
	) {
		conversation.participants.push(user);
	}
}
