import { Resolver, Query, UseMiddleware, Ctx } from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import Notification from "../../../../entity/Notification";
import { ConnectionNotification } from "../../../../entity/ConnectionNotification";
import { NotificationRepository } from "../../../repository/NotificationRepository";
import { NotificationUnionType } from "../../../../models";
import { isAuth } from "../../../middleware";
import { GQLContext } from "../../../../utils/graphql-utils";

@Resolver((of) => Notification)
class GetMyNotificationsResolver {
	@InjectRepository(ConnectionNotification)
	private readonly connectionNotificationRepository: NotificationRepository<ConnectionNotification>;

	@UseMiddleware(isAuth)
	@Query(() => [NotificationUnionType]!, { nullable: true })
	async getMyNotifications(@Ctx() { session }: GQLContext) {
		let connectionNotifications = await this.connectionNotificationRepository.find(
			{
				where: {
					to: {
						id: session.userId,
					},
				},
				relations: ["from", "to"],
			}
		);

		return [...connectionNotifications];
	}
}

export default GetMyNotificationsResolver;
