import * as connectMongoDbSession from "connect-mongodb-session";
import { MongoClient } from "mongodb";
import { env, EnvironmentType } from "../utils/environmentType";

export function genMongoDBSessionStore(session: any) {
	const MongoStore = connectMongoDbSession(session);

	const store = new MongoStore({
		uri:
			(process.env.MONGODB_URI as string) || "mongodb://localhost:27017/ramen",
		collection: "session",
		expires: 1000 * 60 * 60 * 24 * 7,
	});

	store.on("error", function (error) {
		console.log(error);
	});

	return store;
}

export function genMongoDbClient() {
	const uri =
		(process.env.MONGODB_URI as string) || "mongodb://localhost:27017/ramen";

	const client = new MongoClient(uri, {
		useNewUrlParser: true,
		useUnifiedTopology: true,
	});

	return client;
}
