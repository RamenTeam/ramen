import { Arg, Ctx, Mutation, Resolver, UseMiddleware } from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import { User } from "../../../../entity/User";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";
import { ErrorMessage } from "../../../../shared/ErrorMessage.type";
import { GQLContext } from "../../../../utils/graphql-utils";
import { isAuth } from "../../../middleware";
import { ConnectionNotificationRepository } from "../../../repository/ConnectionNotificationRepository";
import { UserRepository } from "../../../repository/UserRepository";
import { RejectConnectionRequest } from "./reject_conn_req.dto";

@Resolver((of) => User)
class RejectConnectionRequestResolver {
	@InjectRepository(ConnectionNotificationRepository)
	private readonly connectionNotificationRepository: ConnectionNotificationRepository;

	@UseMiddleware(isAuth)
	@Mutation(() => ErrorMessage!, { nullable: true })
	async rejectConnectionRequest(
		@Arg("data") { connectionId }: RejectConnectionRequest,
		@Ctx() { session }: GQLContext
	) {
		let connectionNotification = await this.connectionNotificationRepository.findOne(
			{
				where: {
					id: connectionId,
				},
				relations: ["to"],
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

		await this.connectionNotificationRepository.delete({
			id: connectionNotification.id,
		});

		return null;
	}
}

export default RejectConnectionRequestResolver;
