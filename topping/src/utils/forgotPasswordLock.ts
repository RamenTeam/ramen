import { Session } from "express-session";
import { Redis } from "ioredis";
import { User } from "../entity/User";
import { removeAllUserSession } from "./removeUserSession";

export const forgotPasswordLockAccount = async (
	userId: string,
	redis: Redis,
	session?: Session
) => {
	// can't login
	console.log(userId);
	await User.update({ id: userId }, { forgotPasswordLock: true });
	// remove all sessions
	await removeAllUserSession(userId, session as Session, redis);
};
