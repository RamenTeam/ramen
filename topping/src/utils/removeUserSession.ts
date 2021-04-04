import { Session } from "express-session";
import { Redis } from "ioredis";
import {
	REDIS_SESSION_PREFIX,
	USER_SESSION_ID_PREFIX,
} from "../constants/global-variables";

export const removeAllUserSession = async (
	userId: string,
	session: Session,
	redis: Redis
) => {
	const sessionIds = await redis.lrange(
		`${USER_SESSION_ID_PREFIX}${userId}`,
		0,
		-1
	);
	const promises: Promise<any>[] = [];
	for (let i = 0; i < sessionIds.length; i++) {
		promises.push(redis.del(`${REDIS_SESSION_PREFIX}${sessionIds[i]}`));
	}
	await Promise.all(promises);

	if (session) {
		session.destroy((err: any) => {
			if (err) return false;
			return true;
		});
	}
};
