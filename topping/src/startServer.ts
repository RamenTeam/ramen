import "reflect-metadata";
import "dotenv/config";
import { GraphQLServer, Options } from "graphql-yoga";
import { genSchema } from "./utils/genSchema";
import { sessionMiddleware } from "./helper/session";
// import { REDIS } from "./helper/redis";
// import { DEV_BASE_URL } from "./constants/global-variables";
import { env, EnvironmentType } from "./utils/environmentType";
import { formatValidationError } from "./utils/formatValidationError";
import { GQLContext } from "./utils/graphql-utils";
import { ContextParameters } from "graphql-yoga/dist/types";
import { genORMConnection } from "./config/orm.config";
import { printSchema } from "graphql";
import { genREST_API } from "./utils/genREST";
import { logger } from "./config/winston.config";
// import NodeMailerService from "./helper/email";
import { genAPIDocument } from "./utils/genAPIDocument";
import * as fs from "fs";
import * as express from "express";
import { DEV_BASE_URL } from "./constants/global-variables";
import { Connection } from "typeorm";
import { genMongoDbClient } from "./helper/mongodb";
import { MongoClient } from "mongodb";
import { getCookieRoute } from "./helper/cookie";
import * as cookieParser from "cookie-parser";

export const startServer = async () => {
	// MongoDB
	const mongoConn: MongoClient = await genMongoDbClient().connect();

	if (!(mongoConn instanceof MongoClient)) {
		(mongoConn as any).then((err) => console.log(err));
	}

	if (!env(EnvironmentType.PROD)) {
		await mongoConn.db().dropDatabase();
	}

	// TypeORM
	let retries = 5;
	let conn: Connection | null = null;
	while (retries) {
		try {
			conn = await genORMConnection();
			await conn.runMigrations({
				transaction: "none",
			});
			break;
		} catch (error) {
			retries -= 1;
			console.log(error);
			console.log(`retries left: ${retries}`);
			// wait 5 seconds before retry
			await new Promise((res) => setTimeout(res, 5000));
		}
	}

	// GraphQL Server
	const schema = await genSchema();

	const sdl = printSchema(schema);
	await fs.writeFileSync(__dirname + "/schema.graphql", sdl);

	const server = new GraphQLServer({
		schema,
		context: ({
			request,
			connection,
		}: ContextParameters): Partial<GQLContext> => {
			// #NOTE If the request is not http => no request => return back the websocket connection
			if (!request || !request.headers) {
				return connection.context.req;
			}

			return {
				request,
				// redis: new REDIS().server,
				mongodb: mongoConn.db() as any,
				session: request?.session,
				url: request?.protocol + "://" + request?.get("host"),
			};
		},
	} as any);

	// Middleware
	server.express.use(sessionMiddleware);
	server.express.use(express.json());
	server.express.use(express.urlencoded({ extended: true }));
	server.express.use(cookieParser());
	getCookieRoute(server.express);

	// CORS
	const corsOptions = {
		credentials: true,
		origin: DEV_BASE_URL,
	};

	//REST API
	genREST_API(schema, server.express);
	genAPIDocument(server.express);

	const PORT = process.env.PORT || 5000;

	await server
		.start(
			Object.assign(
				{
					cors: corsOptions,
					port: env(EnvironmentType.TEST) ? 8080 : PORT,
					formatError: formatValidationError,
					subscriptions: {
						keepAlive: 10000,
						// #NOTE Callback to wrap the returned data of WebSocket with Session Middleware
						onConnect: (_, ws: any) => {
							console.log("Subscription server connected!");
							// Return back a promise with a response as the WebSocket request
							return new Promise((res) =>
								sessionMiddleware(ws.upgradeReq, {} as any, () => {
									res({ req: ws.upgradeReq });
								})
							);
						},
						onDisconnect: () =>
							console.log("Subscription server disconnected!"),
					},
				} as Options,
				env(EnvironmentType.PROD)
					? {
							// playground: false as any,
					  }
					: {
							endpoint: "/graphql",
					  }
			),
			(options) => {
				logger.info(
					env(EnvironmentType.PROD)
						? {
								REST_API_URI: `${process.env.SERVER_URI}:${options?.port}/api`,
								ENDPOINT: `${process.env.SERVER_URI}:${options?.port}${process.env.SERVER_ENDPOINT}`,
								ENVIRONMENT: process.env.NODE_ENV?.trim(),
								DATABASE_URL: process.env.DATABASE_URL,
								MONGODB_URI: process.env.MONGODB_URI,
								MONGODB_IS_CONNECTED: mongoConn.isConnected(),
						  }
						: {
								REST_API_URI: `${process.env.SERVER_URI}:${options?.port}/api`,
								ENDPOINT: `${process.env.SERVER_URI}:${options?.port}${process.env.SERVER_ENDPOINT}`,
								ENVIRONMENT: process.env.NODE_ENV?.trim(),
								PORT: options.port,
								DATABASE: conn?.options.database,
								MONGODB_URI: process.env.MONGODB_URI,
								MONGODB_IS_CONNECTED: mongoConn.isConnected(),
						  }
				);
			}
		)
		.catch((err) => console.log(err));
};
