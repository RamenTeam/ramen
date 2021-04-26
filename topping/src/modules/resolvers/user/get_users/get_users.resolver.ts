import {
	Resolver,
	Query,
	UseMiddleware,
	FieldResolver,
	Root,
	Ctx,
} from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import { UserRepository } from "../../../repository/UserRepository";
import { User } from "../../../../entity/User";
import { Loader } from "type-graphql-dataloader";
import { GQLContext } from "../../../../utils/graphql-utils";

@Resolver((of) => User)
class GetUsersResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware()
	@Query(() => [User], { nullable: true })
	async getUsers() {
		const users = await this.userRepository.find({
			relations: ["connections"],
		});
		return users;
	}
}

export default GetUsersResolver;
