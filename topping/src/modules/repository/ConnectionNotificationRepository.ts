import { EntityRepository } from "typeorm";
import { ConnectionNotification } from "../../entity/ConnectionNotification";
import { NotificationRepository } from "./NotificationRepository";

@EntityRepository(ConnectionNotification)
export class ConnectionNotificationRepository extends NotificationRepository<ConnectionNotification> {}
