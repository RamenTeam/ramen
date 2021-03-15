import { Resolver, Mutation, Ctx, UseMiddleware } from "type-graphql";
import { User } from "../../../../entity/User";
import { GQLContext } from "../../../../utils/graphql-utils";
import { isAuth } from "../../../middleware/isAuth";
import {
	REDIS_SESSION_PREFIX,
	USER_SESSION_ID_PREFIX,
} from "../../../../constants/global-variables";

@Resolver((of) => User)
class LogoutResolver {
	@UseMiddleware(isAuth)
	@Mutation(() => Boolean!, { nullable: true })
	async logout(@Ctx() { session, redis }: GQLContext) {
		const sessionIds = await redis.lrange(
			`${USER_SESSION_ID_PREFIX}${session.userId}`,
			0,
			-1
		);
		const promises: Promise<any>[] = [];
		for (let i = 0; i < sessionIds.length; i++) {
			promises.push(redis.del(`${REDIS_SESSION_PREFIX}${sessionIds[i]}`));
		}
		await Promise.all(promises);

		if (session) {
			session.destroy((err: any) => {
				if (err) {
					return false;
				}
				return true;
			});
		}
	}
}

export default LogoutResolver;
