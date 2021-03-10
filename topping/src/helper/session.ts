import * as session from "express-session";
import "dotenv/config";
import { EnvironmentType } from "../utils/environmentType";
import { initializeRedisStore } from "./redis";

// Must change the graphql playground "credential" from "omit" to "include"
export const sessionConfiguration = session({
	name: "qid",
	secret: process.env.SESSION_SECRET as string,
	resave: false,
	saveUninitialized: false,
	store: initializeRedisStore(session),
	cookie: {
		httpOnly: true,
		secure: process.env.NODE_ENV === EnvironmentType.PROD,
		maxAge: 1000 * 60 * 60 * 24 * 7,
	},
});
