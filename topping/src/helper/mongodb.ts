import * as connectMongoDbSession from "connect-mongodb-session";
import { MongoClient } from "mongodb";
import { MongoClientOptions } from "mongodb";

const url =
	(process.env.MONGODB_URI as string) || "mongodb://localhost:27017/ramen";

const options: MongoClientOptions = {
	useNewUrlParser: true,
	useUnifiedTopology: true,
};

export function genMongoDBSessionStore(session: any) {
	const MongoStore = connectMongoDbSession(session);

	const store = new MongoStore({
		uri: url,
		collection: "session",
		expires: 1000 * 60 * 60 * 24 * 7,
	});

	store.on("error", function (error) {
		console.log(error);
	});

	return store;
}

export function genMongoDbClient() {
	const client = new MongoClient(url, options);

	return client;
}
