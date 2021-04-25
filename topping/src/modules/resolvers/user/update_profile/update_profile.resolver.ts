import { Arg, Resolver, UseMiddleware, Ctx, Mutation } from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import { yupValidateMiddleware } from "../../../middleware/yupValidate";
import { UserRepository } from "../../../repository/UserRepository";
import { User } from "../../../../entity/User";
import UpdateProfileDto from "./update_profile.dto";
import { ErrorMessage } from "../../../../shared/ErrorMessage.type";
import { isAuth } from "../../../middleware";
import { GQLContext } from "../../../../utils/graphql-utils";
import { GraphQLError } from "graphql";
import { YUP_UPDATE_PROFILE } from "./update_profile.validate";
import NodeMailerService from "../../../../helper/email";
import { env, EnvironmentType } from "../../../../utils/environmentType";
import * as bcrypt from "bcrypt";

@Resolver((of) => User)
class UpdateProfileResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware(isAuth, yupValidateMiddleware(YUP_UPDATE_PROFILE))
	@Mutation(() => ErrorMessage, { nullable: true })
	async updateProfile(
		@Arg("data") data: UpdateProfileDto,
		@Ctx() { session, mongodb }: GQLContext
	) {
		try {
			let user = await this.userRepository.findOne({
				where: { id: session.userId },
			});

			user = user as User;
			user.bio = data.bio || user.bio;
			user.avatarPath = data.avatarPath || user.avatarPath;
			user.email = data.email || user.email;
			user.firstName = data.firstName || user.firstName;
			user.lastName = data.lastName || user.lastName;
			user.username = data.username || user.username;
			user.phoneNumber = data.phoneNumber || user.phoneNumber;
			user.password = data.password
				? await bcrypt.hash(data.password, 10)
				: user.password;
			user.save();

			if (data.email) {
				const link = await new NodeMailerService().createConfirmedEmailLink(
					env(EnvironmentType.PROD)
						? process.env.PROD_SERVER_HOST
						: (process.env.TEST_HOST as any),
					user.id,
					mongodb
				);

				await new NodeMailerService().sendEmail(
					data.email,
					"Ramen | Email Verification",
					link
				);
			}

			return null;
		} catch (error) {
			throw new GraphQLError(error);
		}
	}
}

export default UpdateProfileResolver;
