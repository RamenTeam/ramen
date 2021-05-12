import { EntityRepository } from "typeorm";
import { ConnectionNotification } from "../../entity/ConnectionNotification";
import { NotificationRepository } from "./NotificationRepository";

@EntityRepository(ConnectionNotification)
export class ConnectionNotificationRepository extends NotificationRepository<ConnectionNotification> {
	async findConnectionRequestFromTo(peer1, peer2) {
		return (
			(await this.findOne({
				where: {
					from: { id: peer1 },
					to: { id: peer2 },
				},
			})) ||
			(await this.findOne({
				where: {
					from: { id: peer2 },
					to: { id: peer1 },
				},
			}))
		);
	}
}
