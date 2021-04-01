import { Connection, createConnection, getConnectionOptions } from "typeorm";
import { SnakeNamingStrategy } from "typeorm-naming-strategies";
import { env, EnvironmentType } from "../utils/environmentType";

export const genORMConnection = async (
	logging: boolean = true
): Promise<Connection> => {
	const connectionOptions = await getConnectionOptions(
		env(EnvironmentType.PROD) ? "production-database" : "default"
	);
	const extendedOptions = {
		...connectionOptions,
		database: (connectionOptions.database +
			(env(EnvironmentType.TEST) ? "-testing" : "")) as any,
		dropSchema: env(EnvironmentType.TEST),
		namingStrategy: new SnakeNamingStrategy(),
		logging,
		name: "default",
	};
	if (process.env.DATABASE_URL && env(EnvironmentType.PROD)) {
		Object.assign(extendedOptions, {
			url: process.env.DATABASE_URL,
			ssl: { rejectUnauthorized: false },
		});
	} else {
		Object.assign(extendedOptions, {
			host: process.env.DATABASE_HOST,
			username: process.env.DATABASE_USERNAME,
			password: process.env.DATABASE_PASSWORD,
		});
	}

	return await createConnection(extendedOptions);
};
