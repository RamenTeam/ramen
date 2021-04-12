import * as session from "express-session";
import "dotenv/config";
import { env, EnvironmentType } from "../utils/environmentType";
import * as connectMongoDbSession from "connect-mongodb-session";
import { logger } from "../config/winston.config";
// import { initializeRedisStore } from "./redis";

//FIXME Must change the graphql playground "credential" from "omit" to "include"
const COOKIE_NAME = "a sweet bowl of ramen";

const MongoStore = connectMongoDbSession(session);

const store = new MongoStore({
	uri: process.env.MONGODB_URI as string,
	collection: "sessions",
	expires: 1000 * 60 * 60 * 24 * 7,
});

store.on("error", function (error) {
	console.log(error);
});

// initializeRedisStore(session)
export const sessionConfiguration = session({
	name: COOKIE_NAME,
	secret: process.env.SESSION_SECRET as string,
	resave: false,
	saveUninitialized: false,
	store: store,
	cookie: {
		httpOnly: !env(EnvironmentType.PROD),
		secure: false,
		maxAge: 1000 * 60 * 60 * 24 * 7,
		sameSite: "lax",
	},
});
