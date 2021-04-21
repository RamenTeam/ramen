import {
	Arg,
	Resolver,
	Query,
	UseMiddleware,
	PubSubEngine,
	PubSub,
	Ctx,
} from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import { UserRepository } from "../../../repository/user/UserRepository";
import { User } from "../../../../entity/User";
import { isAuth } from "../../../middleware";
import { FollowUserDto } from "./follow.dto";
import { ErrorMessage } from "../../../../shared/ErrorMessage.type";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";
import { GQLContext } from "../../../../utils/graphql-utils";

@Resolver((of) => User)
class FollowUserResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware(isAuth)
	@Query(() => ErrorMessage, { nullable: true })
	async follow(
		@Arg("data") { userId }: FollowUserDto,
		@Ctx() { session }: GQLContext,
		@PubSub() pubSub: PubSubEngine
	) {
		const user = await this.userRepository.findOne({
			where: {
				id: userId,
			},
		});

		if (!user) {
			return {
				message: CustomMessage.userIsNotFound,
				path: "userId",
			};
		}

		const currentUser = await this.userRepository.findOne({
			where: {
				id: session.userId,
			},
		});

		this.userRepository.updateFollow(currentUser as User)(user);

		//TODO send pub here!

		return null;
	}
}

export default FollowUserResolver;
