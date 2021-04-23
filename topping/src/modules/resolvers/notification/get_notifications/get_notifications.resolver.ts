import { Resolver, Query } from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import Notification from "../../../../entity/Notification";
import { ConnectionNotification } from "../../../../entity/ConnectionNotification";
import { NotificationRepository } from "../../../repository/NotificationRepository";
import { NotificationUnionType } from "../../../../models";

@Resolver((of) => Notification)
class GetNotificationsResolver {
	@InjectRepository(ConnectionNotification)
	private readonly connectionNotificationRepository: NotificationRepository<ConnectionNotification>;

	@Query(() => [NotificationUnionType]!, { nullable: true })
	async getNotifications() {
		let connectionNotifications = await this.connectionNotificationRepository.find(
			{
				relations: ["from", "to"],
			}
		);

		return [...connectionNotifications];
	}
}

export default GetNotificationsResolver;
