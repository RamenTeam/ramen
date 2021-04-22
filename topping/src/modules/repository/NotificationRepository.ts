import { EntityRepository, Repository } from "typeorm";
import Notification from "../../entity/Notification";

@EntityRepository(Notification)
export class NotificationRepository<
	T extends Notification
> extends Repository<T> {}
