import {
	Arg,
	Resolver,
	UseMiddleware,
	PubSubEngine,
	PubSub,
	Ctx,
	Mutation,
} from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import { UserRepository } from "../../../repository/UserRepository";
import { User } from "../../../../entity/User";
import { isAuth } from "../../../middleware";
import { ConnectUserDto } from "./send_conn_req.dto";
import { ErrorMessage } from "../../../../shared/ErrorMessage.type";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";
import { GQLContext } from "../../../../utils/graphql-utils";
import { GLOBAL_TOPIC } from "../../../../constants/global-topics";
import { NotificationPayload, NotificationType } from "../../../../models";
import { ConnectionNotificationRepository } from "../../../repository/ConnectionNotificationRepository";

@Resolver((of) => User)
class ConnectResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@InjectRepository(ConnectionNotificationRepository)
	private readonly connectionNotificationRepository: ConnectionNotificationRepository;

	@UseMiddleware(isAuth)
	@Mutation(() => ErrorMessage, { nullable: true })
	async sendConnectRequest(
		@Arg("data") { userId }: ConnectUserDto,
		@Ctx() { session }: GQLContext,
		@PubSub() pubSub: PubSubEngine
	) {
		let currentUser = await this.userRepository.findOne({
			where: {
				id: session.userId,
			},
			relations: ["connections"],
		});

		if (
			currentUser?.connections.some((connection) => connection.id == userId)
		) {
			return {
				path: "userId",
				message: CustomMessage.connectionDoesExist,
			};
		}

		let isExist = await this.connectionNotificationRepository.findConnectionRequestFromTo(
			userId,
			session.userId
		);

		if (isExist) {
			return {
				path: "sendConnectRequest",
				message: CustomMessage.connectionRequestIsSended,
			};
		}

		if (userId == session.userId) {
			return {
				message: CustomMessage.hmmm___err,
				path: "userId",
			};
		}
		const user = await this.userRepository.findOne({
			where: {
				id: userId,
			},
		});

		if (!user) {
			return {
				message: CustomMessage.userIsNotFound,
				path: "userId",
			};
		}

		const notification = await this.connectionNotificationRepository
			.create({
				from: currentUser,
				to: user,
				label: `${currentUser?.username} want to connect with you!`,
			})
			.save();

		await pubSub
			.publish(GLOBAL_TOPIC.NEW_NOTIFICATION_TOPIC, {
				type: NotificationType.NEW_CONNECTION,
				label: notification.label,
				user: user,
				notificationId: notification.id,
			} as NotificationPayload)
			.catch((err) => {
				throw new Error(err);
			});

		return null;
	}
}

export default ConnectResolver;
