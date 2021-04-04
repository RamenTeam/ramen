import { Arg, Resolver, Query, UseMiddleware } from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import { yupValidateMiddleware } from "../../../middleware/yupValidate";
import { UserRepository } from "../../../repository/user/UserRepository";
import { GetUserDto } from "./get_user.dto";
import { User } from "../../../../entity/User";
import { YUP_USER_READ } from "./get_user.validate";

@Resolver((of) => User)
class GetUserResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware(yupValidateMiddleware(YUP_USER_READ))
	@Query(() => User, { nullable: true })
	async getUser(@Arg("data") { userId }: GetUserDto) {
		const user = await this.userRepository.findOne({
			where: {
				id: userId,
			},
		});

		return user;
	}
}

export default GetUserResolver;
