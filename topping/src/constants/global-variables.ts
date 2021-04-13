import * as _env from "dotenv";

_env.config();

export const DEV_BASE_URL = `http://localhost:${process.env.CLIENT_PORT}`;

export const REDIS_SESSION_PREFIX = "sess: ";
export const USER_SESSION_ID_PREFIX = "userSid:";
export const EMAIL_CONFIRM_PREFIX = "emailConfirm:";
export const FORGOT_PASSWORD_PREFIX = "forgotPassword:";

export const DEFAULT_AVATAR_PATH =
	"https://hieumobile.com/wp-content/uploads/avatar-among-us-9.jpg";
