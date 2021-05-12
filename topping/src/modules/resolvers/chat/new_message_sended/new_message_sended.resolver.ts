import { Arg, Resolver, Root, Subscription } from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import { GLOBAL_TOPIC } from "../../../../constants/global-topics";
import { Message } from "../../../../entity/Message";
import { MessagePayload } from "../../../../models/message_payload";
import { ChatRepository } from "../../../repository/ChatRepository";
import { NewMessageSendedDto } from "./new_message_sended.dto";

@Resolver((type) => Message)
class NewMessageSended {
	@InjectRepository(ChatRepository)
	private readonly chatRepository: ChatRepository;

	@Subscription(() => Message, {
		topics: GLOBAL_TOPIC.NEW_CONVERSATION_TOPIC,
		filter: ({
			payload,
			args,
		}: {
			payload: MessagePayload;
			args: { data: NewMessageSendedDto };
		}) => args.data.conversationId === payload.conversationId,
		nullable: true,
	})
	async newMessageSended(
		@Root() messagePayload: MessagePayload,
		@Arg("data") args: NewMessageSendedDto
	): Promise<Message | undefined> {
		return await this.chatRepository.findOne({
			id: messagePayload.messageId,
		});
	}
}

export default NewMessageSended;
