import { Arg, Resolver, Mutation, UseMiddleware, Ctx } from "type-graphql";
import { User } from "../../../../entity/User";
import { ErrorMessage } from "../../../../shared/ErrorMessage.type";
import { RegisterDto } from "./register.dto";
import { UserRepository } from "../../../repository/user/UserRepository";
import { InjectRepository } from "typeorm-typedi-extensions";
import { yupValidateMiddleware } from "../../../middleware/yupValidate";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";
import { YUP_REGISTER } from "./register.validate";
import NodeMailerService from "../../../../helper/email";
import { GQLContext } from "../../../../utils/graphql-utils";
import { env, EnvironmentType } from "../../../../utils/environmentType";

@Resolver((of) => User)
class RegisterResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware(yupValidateMiddleware(YUP_REGISTER))
	@Mutation(() => ErrorMessage!, { nullable: true })
	async register(@Arg("data") dto: RegisterDto, @Ctx() { redis }: GQLContext) {
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

		const user = await this.userRepository.create(dto).save();

		const link = await new NodeMailerService().createConfirmedEmailLink(
			env(EnvironmentType.PROD)
				? process.env.PROD_SERVER_HOST
				: (process.env.TEST_HOST as any),
			user.id,
			redis
		);

		await new NodeMailerService().sendEmail(
			user.email,
			"Ramen | Email Verification",
			link
		);

		return null;
	}
}

export default RegisterResolver;
