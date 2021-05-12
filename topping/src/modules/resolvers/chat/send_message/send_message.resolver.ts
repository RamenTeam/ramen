import {
	Arg,
	Resolver,
	Mutation,
	PubSub,
	UseMiddleware,
	Ctx,
	Publisher,
} from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import { SendMessageDto } from "./send_message.dto";
import { ErrorMessage } from "../../../../shared/ErrorMessage.type";
import { Message } from "../../../../entity/Message";
import { isAuth } from "../../../middleware/isAuth";
import { GQLContext } from "../../../../utils/graphql-utils";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";
import { ChatRepository } from "../../../repository/ChatRepository";
import { ConversationRepository } from "../../../repository/ConversationRepository";
import { UserRepository } from "../../../repository/UserRepository";
import { MessagePayload } from "../../../../models/message_payload";
import { GLOBAL_TOPIC } from "../../../../constants/global-topics";

@Resolver((of) => Message)
class SendMessageResolver {
	@InjectRepository(ChatRepository)
	private readonly chatRepository: ChatRepository;
	@InjectRepository(ConversationRepository)
	private readonly conversationRepository: ConversationRepository<any>;
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware(isAuth)
	@Mutation(() => ErrorMessage!, { nullable: true })
	async sendMessage(
		@Arg("data") { message, conversationId }: SendMessageDto,
		@PubSub(GLOBAL_TOPIC.NEW_CONVERSATION_TOPIC)
		publish: Publisher<MessagePayload>,
		@Ctx() { session }: GQLContext
	) {
		const conversation = await this.conversationRepository.findOne({
			where: { id: conversationId },
			relations: ["messages"],
		});
		if (!conversation) {
			return {
				path: "conversationId",
				message: CustomMessage.conversationIdIsNotValid,
			};
		}
		const user = await this.userRepository.findOne({
			where: { id: session.userId },
		});
		const chatMessage = await this.chatRepository
			.create({ message, sender: user, conversation })
			.save();

		await this.conversationRepository.findConversationAndUpdateMessage(
			conversation,
			chatMessage
		);
		await publish({
			conversationId: chatMessage.conversation.id,
			messageId: chatMessage.id,
		}).catch((err) => {
			throw new Error(err);
		});
		return null;
	}
}

export default SendMessageResolver;
