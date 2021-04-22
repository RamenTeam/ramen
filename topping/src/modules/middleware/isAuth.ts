import { GraphQLError } from "graphql";
import { MiddlewareFn } from "type-graphql";
import { logger } from "../../config/winston.config";
import { GQLContext } from "../../utils/graphql-utils";

export const isAuth: MiddlewareFn<GQLContext> = (
	{ context: { session } },
	next
) => {
	isAuthFnc(session);
	return next();
};

export const isAuthFnc = (session) => {
	logger.info(session);
	if (!session?.userId) {
		throw new GraphQLError("not authenticated");
	}
	console.log("authenticated");
};
