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

	await mongodb.collection(`session`).deleteMany({
		tag: `${USER_SESSION_ID_PREFIX}${userId}`,
	});

	if (session) {
		session.destroy((err: any) => {
			if (err) return false;
			return true;
		});
	}
};
