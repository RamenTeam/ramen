import { Arg, Resolver, Mutation, UseMiddleware } from "type-graphql";
import { User } from "../../../../entity/User";
import { ErrorMessage } from "../../../../shared/ErrorMessage.type";
import { RegisterDto, YUP_REGISTER } from "./register.dto";
import { UserRepository } from "../../../repository/user/UserRepository";
import { InjectRepository } from "typeorm-typedi-extensions";
import { yupValidateMiddleware } from "../../../middleware/yupValidate";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";

@Resolver((of) => User)
class RegisterResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware(yupValidateMiddleware(YUP_REGISTER))
	@Mutation(() => [ErrorMessage]!, { nullable: true })
	async register(@Arg("data") dto: RegisterDto) {
		let errors: ErrorMessage[] = [];

		if (!!(await this.userRepository.findByEmail(dto.email))) {
			errors.push({
				path: "email",
				message: CustomMessage.emailIsRegister,
			});
		}

		if (!!(await this.userRepository.findByUsername(dto.username))) {
			errors.push({
				path: "username",
				message: CustomMessage.usernameIsTaken,
			});
		}

		if (errors.length != 0) return errors;

		await this.userRepository
			.create(dto)
			.save()
			.then((err) => console.log(err));

		return null;
	}
}

export default RegisterResolver;
