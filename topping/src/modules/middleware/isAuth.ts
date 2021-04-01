import { GraphQLError } from "graphql";
import { MiddlewareFn } from "type-graphql";
import { logger } from "../../config/winston.config";
import { GQLContext } from "../../utils/graphql-utils";

export const isAuth: MiddlewareFn<GQLContext> = (
	{ args, context: { session } },
	next
) => {
	logger.info(session);
	if (!session.userId) {
		throw new GraphQLError("not authenticated");
	}
	console.log("authenticated");
	return next();
};
