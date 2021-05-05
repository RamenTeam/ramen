import { Arg, Ctx, Mutation, Resolver, UseMiddleware } from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import { User } from "../../../../entity/User";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";
import { ErrorMessage } from "../../../../shared/ErrorMessage.type";
import { GQLContext } from "../../../../utils/graphql-utils";
import { isAuth } from "../../../middleware";
import { ConnectionNotificationRepository } from "../../../repository/ConnectionNotificationRepository";
import { UserRepository } from "../../../repository/UserRepository";
import { AcceptConnectionRequestDto } from "./accept_conn_req.dto";

@Resolver((of) => User)
class AcceptConnectionRequestResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@InjectRepository(ConnectionNotificationRepository)
	private readonly connectionNotificationRepository: ConnectionNotificationRepository;

	@UseMiddleware(isAuth)
	@Mutation(() => ErrorMessage!, { nullable: true })
	async acceptConnectionRequest(
		@Arg("data") { connectionId }: AcceptConnectionRequestDto,
		@Ctx() { session }: GQLContext
	) {
		let connectionNotification = await this.connectionNotificationRepository.findOne(
			{
				where: {
					id: connectionId,
				},
				relations: ["from", "to"],
			}
		);
		if (connectionNotification?.to.id !== session.userId) {
			return {
				path: "toId",
				message: CustomMessage.connectionRequestAuthorized,
			};
		}
		if (!connectionNotification) {
			return {
				path: "connectionId",
				message: CustomMessage.connectionRequestIsNotExist,
			};
		}
		let from = await this.userRepository.findOne({
			where: {
				id: connectionNotification.from.id,
			},
			relations: ["connections"],
		});
		let to = await this.userRepository.findOne({
			where: {
				id: connectionNotification.to.id,
			},
			relations: ["connections"],
		});
		if (!from || !to) {
			return {
				path: "acceptConnectionRequest",
				message: CustomMessage.hmmm___err,
			};
		}

		from.connections.push(to);
		from.save();

		to.connections.push(from);
		to.save();

		await this.connectionNotificationRepository.delete({
			id: connectionNotification.id,
			from: {
				id: from.id,
			},
			to: {
				id: to.id,
			},
		});

		await this.connectionNotificationRepository.delete({
			id: connectionNotification.id,
			from: {
				id: to.id,
			},
			to: {
				id: from.id,
			},
		});

		return null;
	}
}

export default AcceptConnectionRequestResolver;
