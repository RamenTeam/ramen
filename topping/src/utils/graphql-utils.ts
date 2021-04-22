import { Request } from "express";
import { Session } from "express-session";
import { Redis } from "ioredis";
import { Db } from "mongodb";
import { ExecutionParams } from "subscriptions-transport-ws";

declare module "express-session" {
	export interface SessionData {
		cookie: Cookie;
		userId: string;
	}
}

export interface GQLDataMapper {
	context: GQLContext;
	root: any;
	info: any;
	args: any;
}

export interface SessionStorage extends Session {
	userId?: string;
}

export type GQLContext = {
	request: Request;
	session: SessionStorage;
	url: string;
	redis: Redis;
	mongodb: Db;
	connection: ExecutionParams;
};

export class SubPayload {}

export class SubArgument {}

export interface SubscriptionFilter<
	P extends SubPayload,
	A extends SubArgument
> {
	payload: P;
	args: {
		data: A;
	};
	context: GQLContext;
}
