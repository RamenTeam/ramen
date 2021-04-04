import { Resolver, Ctx, UseMiddleware, Query } from "type-graphql";
import { User } from "../../../../entity/User";
import { UserRepository } from "../../../repository/user/UserRepository";
import { InjectRepository } from "typeorm-typedi-extensions";
import { GQLContext } from "../../../../utils/graphql-utils";
import { isAuth } from "../../../middleware/isAuth";

@Resolver((of) => User)
class MeResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware(isAuth)
	@Query(() => User!, { nullable: true })
	async me(@Ctx() { session }: GQLContext) {
		return await this.userRepository.findOne({
			where: { id: session?.userId },
		});
	}
}

export default MeResolver;
