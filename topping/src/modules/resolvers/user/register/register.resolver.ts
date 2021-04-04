import { Arg, Resolver, Mutation, UseMiddleware } from "type-graphql";
import { User } from "../../../../entity/User";
import { ErrorMessage } from "../../../../shared/ErrorMessage.type";
import { RegisterDto } from "./register.dto";
import { UserRepository } from "../../../repository/user/UserRepository";
import { InjectRepository } from "typeorm-typedi-extensions";
import { yupValidateMiddleware } from "../../../middleware/yupValidate";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";
import { YUP_REGISTER } from "./register.validate";

@Resolver((of) => User)
class RegisterResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware(yupValidateMiddleware(YUP_REGISTER))
	@Mutation(() => ErrorMessage!, { nullable: true })
	async register(@Arg("data") dto: RegisterDto) {
		if (!!(await this.userRepository.findByEmail(dto.email))) {
			return {
				path: "email",
				message: CustomMessage.emailIsRegister,
			};
		}

		if (!!(await this.userRepository.findByUsername(dto.username))) {
			return {
				path: "username",
				message: CustomMessage.usernameIsTaken,
			};
		}

		if (!!(await this.userRepository.findByPhoneNumber(dto.phoneNumber))) {
			return {
				path: "phoneNumber",
				message: CustomMessage.phoneNumberIsTaken,
			};
		}

		await this.userRepository
			.create(dto)
			.save()
			.then((err) => console.log(err));

		return null;
	}
}

export default RegisterResolver;
