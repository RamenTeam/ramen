import { Arg, Resolver, Mutation, UseMiddleware, Ctx } from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import { UserRepository } from "../../../repository/user/UserRepository";
import { User } from "../../../../entity/User";
import { SendForgotPasswordDto } from "./send_forgot_password_email.dto";
import { yupValidateMiddleware } from "../../../middleware";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";
import { forgotPasswordLockAccount } from "../../../../utils/forgotPasswordLock";
import { GQLContext } from "../../../../utils/graphql-utils";
import NodeMailerService from "../../../../helper/email";
import { YUP_SEND_FORGOT_PASSWORD_EMAIL } from "./send_forgot_password_email.validate";
import { ForgotPasswordChangeDto } from "./forgot_password_change.dto";
import { YUP_CHANGE_PASSWORD } from "./forgot_password_change.validate";
import { ErrorMessage } from "../../../../shared/ErrorMessage.type";
import { FORGOT_PASSWORD_PREFIX } from "../../../../constants/global-variables";
import * as bcrypt from "bcrypt";
import "dotenv/config";
import { env, EnvironmentType } from "../../../../utils/environmentType";

@Resolver((of) => User)
class ForgotPasswordResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware(yupValidateMiddleware(YUP_SEND_FORGOT_PASSWORD_EMAIL))
	@Mutation(() => ErrorMessage!, { nullable: true })
	async sendForgotPasswordEmail(
		@Arg("data") { email }: SendForgotPasswordDto,
		@Ctx() { redis }: GQLContext
	) {
		const user = await this.userRepository.findOne({ where: { email } });
		if (!user) {
			return {
				path: "email",
				message: CustomMessage.userIsNotFound,
			};
		}
		console.log(user);
		await forgotPasswordLockAccount(user.id, redis);
		// Send reset password link to email
		const link = await new NodeMailerService().createForgotPasswordLink(
			env(EnvironmentType.PROD)
				? process.env.PROD_SERVER_HOST
				: (process.env.TEST_HOST as any),
			user.id,
			redis
		);

		await new NodeMailerService().sendEmail(
			email,
			"Ramen | Forgot Password",
			link
		);

		return null;
	}

	@UseMiddleware(yupValidateMiddleware(YUP_CHANGE_PASSWORD))
	@Mutation(() => ErrorMessage!, { nullable: true })
	async forgotPasswordChange(
		@Arg("data") { key, newPassword }: ForgotPasswordChangeDto,
		@Ctx() { redis }: GQLContext
	) {
		const userId = await redis.get(`${FORGOT_PASSWORD_PREFIX}${key}`);
		if (!userId) {
			return [
				{
					path: "key",
					message: CustomMessage.expiredKeyError,
				},
			];
		}
		await this.userRepository.update(
			{ id: userId as string },
			{
				password: await bcrypt.hash(newPassword, 10),
				forgotPasswordLock: false,
			}
		);

		return null;
	}
}

export default ForgotPasswordResolver;
