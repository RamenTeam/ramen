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
import { YUP_UPDATE_PROFILE } from "./update_profile.test";

@Resolver((of) => User)
class UpdateProfileResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware(isAuth, yupValidateMiddleware(YUP_UPDATE_PROFILE))
	@Mutation(() => ErrorMessage, { nullable: true })
	async updateProfile(
		@Arg("data") data: UpdateProfileDto,
		@Ctx() { session }: GQLContext
	) {
		try {
			let user = await this.userRepository.findOne({
				where: { id: session.userId },
			});

			if (user) {
				user = user as User;
				user.bio = data.bio || user.bio;
				user.avatarPath = data.avatarPath || user.avatarPath;
				user.email = data.email || user.email;
				user.firstName = data.firstName || user.firstName;
				user.lastName = data.lastName || user.lastName;
				user.username = data.username || user.username;
				user.phoneNumber = data.phoneNumber || user.phoneNumber;
				user.save();
			}

			return null;
		} catch (error) {
			throw new GraphQLError(error);
		}
	}
}

export default UpdateProfileResolver;
