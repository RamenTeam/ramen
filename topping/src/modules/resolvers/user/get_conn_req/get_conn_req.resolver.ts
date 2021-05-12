import { Resolver, Query, Arg, UseMiddleware, Ctx } from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import Notification from "../../../../entity/Notification";
import { ConnectionNotification } from "../../../../entity/ConnectionNotification";
import { isAuth } from "../../../middleware";
import { GetConnectionRequestDto } from "./get_conn_req.dto";
import { GQLContext } from "../../../../utils/graphql-utils";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";
import { ConnectionNotificationRepository } from "../../../repository/ConnectionNotificationRepository";

@Resolver((of) => Notification)
class GetConnectionRequestResolver {
	@InjectRepository(ConnectionNotificationRepository)
	private readonly connectionNotificationRepository: ConnectionNotificationRepository;

	@UseMiddleware(isAuth)
	@Query(() => ConnectionNotification, { nullable: true })
	async getConnectionRequest(
		@Arg("data") { userId }: GetConnectionRequestDto,
		@Ctx() { session }: GQLContext
	) {
		let connectionNotification =
			await this.connectionNotificationRepository.findConnectionRequestFromTo(
				userId,
				session.userId
			);

		if (!connectionNotification) {
			return {
				path: "getConnectionRequest",
				message: CustomMessage.connectionRequestIsNotExist,
			};
		}

		return connectionNotification;
	}
}

export default GetConnectionRequestResolver;
