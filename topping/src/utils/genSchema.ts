import { GraphQLSchema, printSchema } from "graphql";
import { buildSchema } from "type-graphql";
import { Container } from "typedi";
import * as path from "path";
import { redisPubSub } from "../helper/redis";
import * as fs from "fs";

const genSchema = async (): Promise<GraphQLSchema> => {
	const modulePath = "../modules/**/*.resolver.ts";
	const schema = await buildSchema({
		resolvers: [path.join(__dirname, modulePath)],
		container: Container,
		pubSub: redisPubSub,
	});

	return schema;
};

export default genSchema;
