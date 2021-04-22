import { Root, Subscription, UseMiddleware } from "type-graphql";
import { GLOBAL_TOPIC } from "../../../constants/global-topics";
import {
	NotificationPayload,
	NotificationType,
	NotificationUnionType,
} from "../../../models";
import { SubscriptionFilter } from "../../../utils/graphql-utils";
import { NotificationRepository } from "../../repository/NotificationRepository";
import { InjectRepository } from "typeorm-typedi-extensions";
import { ConnectionNotification } from "../../../entity/ConnectionNotification";
import { isAuthFnc } from "../../middleware/isAuth";

//TODO Union Type here
class NotificationResolver {
	@InjectRepository(NotificationRepository)
	private readonly notificationRepository: NotificationRepository<any>;

	@Subscription(() => NotificationUnionType, {
		topics: ({ context }) => {
			isAuthFnc(context?.session);
			return GLOBAL_TOPIC.NEW_NOTIFICATION_TOPIC;
		},
		filter: ({
			payload,
			context,
		}: SubscriptionFilter<NotificationPayload, any>) =>
			context.session.userId === payload.user.id,
		nullable: true,
	})
	async newNotificationAdded(@Root() notificationPayload: NotificationPayload) {
		switch (notificationPayload.type) {
			case NotificationType.NEW_CONNECTION:
				let notification = await this.notificationRepository.findOne({
					where: {
						id: notificationPayload.notificationId,
					},
				});
				return notification as ConnectionNotification;
			default:
				return null;
		}
	}
}

export default NotificationResolver;
