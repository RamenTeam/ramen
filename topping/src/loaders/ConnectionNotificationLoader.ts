import * as DataLoader from "dataloader";
import { In } from "typeorm";
import { ConnectionNotification } from "../entity/ConnectionNotification";

type BatchConnectionNotifications = (
	ids: string[]
) => Promise<ConnectionNotification[]>;

const batchConnectionNotifications: BatchConnectionNotifications = async (
	ids
) => {
	const connectionNotificationsByToId: ConnectionNotification[] = await ConnectionNotification.find(
		{
			where: {
				to: {
					id: In([...ids]),
				},
			},
			relations: ["from", "to"],
		}
	);

	if (connectionNotificationsByToId.length == 0) {
		return [];
	}

	console.log(connectionNotificationsByToId);

	const connectionNotificationMap: {
		[key: string]: ConnectionNotification;
	} = {};

	connectionNotificationsByToId.forEach(
		(conn) => (connectionNotificationMap[conn.to.id] = conn)
	);

	return ids.map((id) => connectionNotificationMap[id]);
};

export const connectionNotificationLoader = () =>
	new DataLoader<string, ConnectionNotification[]>(
		batchConnectionNotifications as any
	);
