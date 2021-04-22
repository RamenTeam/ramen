import { Arg, Root, Subscription } from "type-graphql";
import { GLOBAL_TOPIC } from "../../../constants/global-topics";
import NewNotificationAddedDto from "./new_notification_added.dto";
import { NotificationPayload, NotificationType } from "../../../models";
import { SubscriptionFilter } from "../../../utils/graphql-utils";
import { NotificationRepository } from "../../repository/NotificationRepository";
import { InjectRepository } from "typeorm-typedi-extensions";
import Notification from "../../../entity/Notification";

//TODO Union Type here
class NotificationResolver {
	@InjectRepository(NotificationRepository)
	private readonly notificationRepository: NotificationRepository<any>;

	@Subscription(() => Notification, {
		topics: GLOBAL_TOPIC.NEW_NOTIFICATION_TOPIC,
		filter: ({
			payload,
			args,
		}: SubscriptionFilter<NotificationPayload, NewNotificationAddedDto>) =>
			args.data.userId === payload.user.id,
		nullable: true,
	})
	async newNotificationAdded(
		@Root() notificationPayload: NotificationPayload,
		@Arg("data") { userId }: NewNotificationAddedDto
	) {
		switch (notificationPayload.type) {
			case NotificationType.NEW_CONNECTION:
				let notification = await this.notificationRepository.findOne({
					where: {
						id: notificationPayload.notificationId,
					},
				});
				return notification;
			default:
				return null;
		}
	}
}

export default NotificationResolver;
