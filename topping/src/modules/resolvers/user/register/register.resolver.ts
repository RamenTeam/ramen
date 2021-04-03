import { Arg, Resolver, Mutation, UseMiddleware } from "type-graphql";
import { User } from "../../../../entity/User";
import { ErrorMessage } from "../../../../shared/ErrorMessage.type";
import { RegisterDto, YUP_REGISTER } from "./register.dto";
import { UserRepository } from "../../../repository/user/UserRepository";
import { InjectRepository } from "typeorm-typedi-extensions";
import { yupValidateMiddleware } from "../../../middleware/yupValidate";

@Resolver((of) => User)
class RegisterResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware(yupValidateMiddleware(YUP_REGISTER))
	@Mutation(() => ErrorMessage!, { nullable: true })
	async register(@Arg("data") dto: RegisterDto) {
		const res = await this.userRepository.findByEmailOrCreate({
			...dto,
		});

		return res;
	}
}

export default RegisterResolver;
