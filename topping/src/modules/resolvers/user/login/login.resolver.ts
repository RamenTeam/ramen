import { Arg, Resolver, Mutation, Ctx, UseMiddleware } from "type-graphql";
import { User } from "../../../../entity/User";
import { ErrorMessage } from "../../../../shared/ErrorMessage.type";
import { LoginDto } from "./login.dto";
import { UserRepository } from "../../../repository/user/UserRepository";
import { InjectRepository } from "typeorm-typedi-extensions";
import * as bcrypt from "bcrypt";
import { GQLContext } from "../../../../utils/graphql-utils";
import {
	REDIS_SESSION_PREFIX,
	USER_SESSION_ID_PREFIX,
} from "../../../../constants/global-variables";
import { yupValidateMiddleware } from "../../../middleware/yupValidate";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";
import { YUP_LOGIN } from "./login.validate";

@Resolver((of) => User)
class LoginResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware(yupValidateMiddleware(YUP_LOGIN))
	@Mutation(() => ErrorMessage!, { nullable: true })
	async login(
		@Arg("data") { email, password }: LoginDto,
		@Ctx() { session, mongodb, request }: GQLContext
	) {
		let user = await this.userRepository.findByEmail(email);

		if (!user) {
			return {
				path: "email",
				message: CustomMessage.accountIsNotRegister,
			};
		}

		user = user as User;

		if (!user.isVerified) {
			return {
				path: "isVerified",
				message: CustomMessage.userIsNotVerified,
			};
		}

		if (user.isBanned) {
			return {
				path: "isBanned",
				message: CustomMessage.userIsBanned,
			};
		}
		//TODO Check banned

		const passwordMatch = await bcrypt.compare(password, user.password);

		if (!passwordMatch) {
			return {
				path: "password",
				message: CustomMessage.passwordIsNotMatch,
			};
		}

		if (session?.userId) {
			return {
				path: "login",
				message: CustomMessage.userHasLoggedIn,
			};
		}

		session.userId = user.id;
		if (request?.sessionID) {
			mongodb.collection(`session`).insertOne({
				tag: `${USER_SESSION_ID_PREFIX}${user.id}`,
				[`${REDIS_SESSION_PREFIX}`]: session.id,
			});
		}
		session.save();
		return null;
	}
}

export default LoginResolver;
