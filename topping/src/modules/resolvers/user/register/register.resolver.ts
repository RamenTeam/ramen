import {
	Arg,
	Resolver,
	Mutation,
	Query,
	Ctx,
	UseMiddleware,
} from "type-graphql";
import { User } from "../../../../entity/User";
import { Error as ErrorSchema } from "../../../common/error.schema";
import { RegisterInput } from "./register.dto";
import { UserRepository } from "../../../repository/user/UserRepository";
import { InjectRepository } from "typeorm-typedi-extensions";
import { GQLContext } from "../../../../utils/graphql-utils";
import { yupValidateMiddleware } from "../../../middleware/yupValidate";
import { YUP_REGISTER } from "../../../common/yupSchema";

@Resolver((of) => User)
class RegisterResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@Query(() => String)
	hello(@Ctx() { request }: GQLContext) {
		console.log(request.session);
		return "Hello World";
	}

	@UseMiddleware(yupValidateMiddleware(YUP_REGISTER))
	@Mutation(() => ErrorSchema!, { nullable: true })
	async register(
		@Arg("data") { email, firstName, lastName, password }: RegisterInput
	) {
		const res = await this.userRepository.findByEmailOrCreate({
			email,
			firstName,
			lastName,
			password,
		});

		return res;
	}
}

export default RegisterResolver;
