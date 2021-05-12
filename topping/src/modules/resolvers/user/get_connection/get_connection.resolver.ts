import { Resolver, Query, Arg, UseMiddleware, Ctx } from "type-graphql";
import { InjectRepository } from "typeorm-typedi-extensions";
import Notification from "../../../../entity/Notification";
import { isAuth } from "../../../middleware";
import { GQLContext } from "../../../../utils/graphql-utils";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";
import { GetConnectionDto } from "./get_connection.dto";
import { UserRepository } from "../../../repository/UserRepository";
import { User } from "../../../../entity/User";

@Resolver((of) => Notification)
class GetConnectionRequestResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware(isAuth)
	@Query(() => User, { nullable: true })
	async getConnectionRequest(
		@Arg("data") { userId }: GetConnectionDto,
		@Ctx() { session }: GQLContext
	) {
		let user = await this.userRepository.findOne({
			where: {
				id: session.userId,
			},
			relations: ["connections"],
		});

		let userInConnection = user?.connections.filter(
			(connection) => connection.id == userId
		);
		if (userInConnection?.length == 0) {
			return {
				path: "userId",
				message: CustomMessage.userIsNotInYourConnection,
			};
		}
		return userInConnection?.[0];
	}
}

export default GetConnectionRequestResolver;
