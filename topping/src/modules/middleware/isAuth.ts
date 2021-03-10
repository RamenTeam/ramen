import { GraphQLError } from "graphql";
import { MiddlewareFn } from "type-graphql";
import { GQLContext } from "../../utils/graphql-utils";

export const isAuth: MiddlewareFn<GQLContext> = (
	{ args, context: { session } },
	next
) => {
	console.log(session);
	if (!session.userId) {
		throw new GraphQLError("not authenticated");
	}
	console.log("authenticated");
	return next();
};
