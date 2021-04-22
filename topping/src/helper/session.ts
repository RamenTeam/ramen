import * as session from "express-session";
import "dotenv/config";
import { env, EnvironmentType } from "../utils/environmentType";
import { genMongoDBSessionStore } from "./mongodb";
// import { initializeRedisStore } from "./redis";

//FIXME Must change the graphql playground "credential" from "omit" to "include"
const COOKIE_NAME = "noodle";

// initializeRedisStore(session)
export const sessionMiddleware = session({
	name: COOKIE_NAME,
	secret: process.env.SESSION_SECRET as string,
	resave: false,
	saveUninitialized: false,
	store: genMongoDBSessionStore(session),
	cookie: {
		httpOnly: !env(EnvironmentType.PROD),
		secure: false,
		maxAge: 1000 * 60 * 60 * 24 * 7,
		sameSite: "lax",
	},
});
