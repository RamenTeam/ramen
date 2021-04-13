import { Session } from "express-session";
// import { Redis } from "ioredis";
import { Db } from "mongodb";
import {
	REDIS_SESSION_PREFIX,
	USER_SESSION_ID_PREFIX,
} from "../constants/global-variables";

export const removeAllUserSession = async (
	userId: string,
	session: Session,
	mongodb: Db
) => {
	// const sessionIds = await redis.lrange(
	// 	`${USER_SESSION_ID_PREFIX}${userId}`,
	// 	0,
	// 	-1
	// );
	const sessionIds = await mongodb
		.collection(`${USER_SESSION_ID_PREFIX}${userId}`)
		.find()
		.toArray();
	const promises: Promise<any>[] = [];
	for (let i = 0; i < sessionIds.length; i++) {
		promises.push(
			mongodb.collection(`${USER_SESSION_ID_PREFIX}${userId}`).deleteOne({
				[`${REDIS_SESSION_PREFIX}`]: `${sessionIds[i]}`,
			})
		);
	}
	await Promise.all(promises);

	if (session) {
		session.destroy((err: any) => {
			if (err) return false;
			return true;
		});
	}
};
