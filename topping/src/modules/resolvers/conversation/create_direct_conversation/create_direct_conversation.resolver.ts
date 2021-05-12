import { Arg, Ctx, Mutation, Resolver, UseMiddleware } from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import { GQLContext } from "../../../../utils/graphql-utils";
import { isAuth, yupValidateMiddleware } from "../../../middleware";
import { ErrorMessage } from "../../../../shared/ErrorMessage.type";
import {
	CreateDirectConversationDto,
	YUP_DIRECT_CONVERSATION_CREATE,
} from "./create_direct_conversation.dto";
import { User } from "../../../../entity/User";
import { DirectConversation } from "../../../../entity/DirectConversation";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";
import { DirectConversationRepository } from "../../../repository/DirectConversationRepository";
import { UserRepository } from "../../../repository/UserRepository";

@Resolver((of) => DirectConversation)
class CreateDirectConversation {
	@InjectRepository(DirectConversationRepository)
	private readonly directConversationRepository: DirectConversationRepository;
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware(isAuth, yupValidateMiddleware(YUP_DIRECT_CONVERSATION_CREATE))
	@Mutation(() => ErrorMessage!, { nullable: true })
	async createDirectConversation(
		@Arg("data") { toId }: CreateDirectConversationDto,
		@Ctx() { session }: GQLContext
	) {
		const user = await this.userRepository.findOne({
			where: { id: session.userId },
			relations: ["connections", "conversations", "conversations.participants"],
		});

		const to = await this.userRepository.findOne({
			where: { id: toId },
			relations: ["connections", "conversations", "conversations.participants"],
		});

		if (!to) {
			return {
				path: "toId",
				message: CustomMessage.userIsNotFound,
			};
		}

		let userInConnection = user?.connections.filter(
			(connection) => connection.id === toId
		);

		if (userInConnection?.length === 0) {
			return {
				path: "toId",
				message: CustomMessage.userIsNotInYourConnection,
			};
		}

		let toConversation;
		await user?.conversations.forEach((conversation) => {
			toConversation = conversation.participants.filter(
				(participant) => participant.id === toId
			);
		});
		if (toConversation) {
			return {
				path: "toId",
				message: CustomMessage.conversationHasBeenCreated,
			};
		}

		const createdConversation = await this.directConversationRepository.create({
			participants: [user as User, to],
		});

		[user as User, to].forEach(
			async (u) =>
				await this.userRepository.findUserAndUpdateConversation(
					u,
					createdConversation
				)
		);

		await user?.save();
		await to.save();
		await createdConversation.save();

		return null;
	}
}

export default CreateDirectConversation;
