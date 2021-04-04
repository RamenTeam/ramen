import { Arg, Resolver, Mutation, UseMiddleware } from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import { UserRepository } from "../../../repository/user/UserRepository";
import { User } from "../../../../entity/User";
import { ForgotPasswordDto, YUP_FORGOT_PASSWORD } from "./forgot_password.dto";
import { yupValidateMiddleware } from "../../../middleware";

@Resolver((of) => User)
class GetUserResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware(yupValidateMiddleware(YUP_FORGOT_PASSWORD))
	@Mutation(() => User, { nullable: true })
	async getUser(@Arg("data") { email }: ForgotPasswordDto) {
		const user = await this.userRepository.findOne({
			where: {
				email,
			},
		});
	}
}

export default GetUserResolver;
