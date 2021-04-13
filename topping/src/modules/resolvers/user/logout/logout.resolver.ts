import { Resolver, Mutation, Ctx, UseMiddleware } from "type-graphql";
import { User } from "../../../../entity/User";
import { GQLContext } from "../../../../utils/graphql-utils";
import { isAuth } from "../../../middleware/isAuth";
import { removeAllUserSession } from "../../../../utils/removeUserSession";

@Resolver((of) => User)
class LogoutResolver {
	@UseMiddleware(isAuth)
	@Mutation(() => Boolean!, { nullable: true })
	async logout(@Ctx() { session, mongodb }: GQLContext) {
		if (!session?.userId) {
			return false;
		}
		const res = await removeAllUserSession(session?.userId, session, mongodb);
		return res;
	}
}

export default LogoutResolver;
