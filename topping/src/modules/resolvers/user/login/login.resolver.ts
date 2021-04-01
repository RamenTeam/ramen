import { Arg, Resolver, Mutation, Ctx, UseMiddleware } from "type-graphql";
import { User } from "../../../../entity/User";
import { ErrorMessage } from "../../../../shared/ErrorMessage.type";
import { LoginDto, YUP_LOGIN } from "./login.dto";
import { UserRepository } from "../../../repository/user/UserRepository";
import { InjectRepository } from "typeorm-typedi-extensions";
import * as bcrypt from "bcrypt";
import { GQLContext } from "../../../../utils/graphql-utils";
import { USER_SESSION_ID_PREFIX } from "../../../../constants/global-variables";
import { yupValidateMiddleware } from "../../../middleware/yupValidate";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";

@Resolver((of) => User)
class LoginResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware(yupValidateMiddleware(YUP_LOGIN))
	@Mutation(() => ErrorMessage!, { nullable: true })
	async login(
		@Arg("data") { email, password }: LoginDto,
		@Ctx() { request, session, redis }: GQLContext
	) {
		const user = await this.userRepository.findByEmail(email);
		if (!user) {
			return {
				path: "email",
				message: CustomMessage.accountIsNotRegister,
			};
		}
		const passwordMatch = await bcrypt.compare(password, user.password);
		if (!passwordMatch) {
			return {
				path: "password",
				message: CustomMessage.passwordIsNotMatch,
			};
		}
		if (session.userId) {
			return {
				path: "login",
				message: CustomMessage.userHasLoggedIn,
			};
		}

		session.userId = user.id;

		if (request?.sessionID) {
			redis.lpush(`${USER_SESSION_ID_PREFIX}${user.id}`, user.id);
		}
		session.save();
		return null;
	}
}

export default LoginResolver;
