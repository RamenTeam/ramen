import { Arg, Resolver, Query, UseMiddleware } from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import { yupValidateMiddleware } from "../../../middleware/yupValidate";
import { UserRepository } from "../../../repository/user/UserRepository";
import { GetUserDto, YUP_USER_READ } from "./get_user.dto";
import { User } from "../../../../entity/User";

@Resolver((of) => User)
class GetUsersResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware()
	@Query(() => [User], { nullable: true })
	async getUsers() {
		const users = await this.userRepository.find({
			relations: ["conversations"],
		});

		return users;
	}
}

export default GetUsersResolver;
