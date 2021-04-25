import { Root, Subscription, UseMiddleware } from "type-graphql";
import { GLOBAL_TOPIC } from "../../../../constants/global-topics";
import {
	NotificationPayload,
	NotificationType,
	NotificationUnionType,
} from "../../../../models";
import { SubscriptionFilter } from "../../../../utils/graphql-utils";
import { NotificationRepository } from "../../../repository/NotificationRepository";
import { InjectRepository } from "typeorm-typedi-extensions";
import { ConnectionNotification } from "../../../../entity/ConnectionNotification";
import { isAuthFnc } from "../../../middleware/isAuth";

class NewNotificationAddedResolver {
	@InjectRepository(NotificationRepository)
	private readonly connectionNotificationRepository: NotificationRepository<ConnectionNotification>;

	@Subscription(() => NotificationUnionType, {
		topics: ({ context }) => {
			isAuthFnc(context?.session);
			return GLOBAL_TOPIC.NEW_NOTIFICATION_TOPIC;
		},
		filter: ({
			payload,
			context,
		}: SubscriptionFilter<NotificationPayload, any>) => {
			console.log(payload, context.session);
			return context.session.userId === payload.user.id;
		},
		nullable: true,
	})
	async newNotificationAdded(@Root() notificationPayload: NotificationPayload) {
		switch (notificationPayload.type) {
			case NotificationType.NEW_CONNECTION:
				let notification = await this.connectionNotificationRepository.findOne({
					where: {
						id: notificationPayload.notificationId,
					},
					relations: ["from", "to"],
				});
				return notification;
			default:
				return null;
		}
	}
}

export default NewNotificationAddedResolver;
