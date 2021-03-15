import {
	Arg,
	Resolver,
	Mutation,
	Query,
	Ctx,
	UseMiddleware,
} from "type-graphql";
import { User } from "../../../../entity/User";
<<<<<<< HEAD
import { ErrorMessage } from "../../../../shared/ErrorMessage.type";
import { RegisterDto, YUP_REGISTER } from "./register.dto";
=======
import { Error as ErrorSchema } from "../../../common/error.schema";
import { RegisterInput } from "./register.dto";
>>>>>>> 7fe3bd454c20bc492bb571134790a68fceba718e
import { UserRepository } from "../../../repository/user/UserRepository";
import { InjectRepository } from "typeorm-typedi-extensions";
import { GQLContext } from "../../../../utils/graphql-utils";
import { yupValidateMiddleware } from "../../../middleware/yupValidate";

@Resolver((of) => User)
class RegisterResolver {
	@InjectRepository(UserRepository)
	private readonly userRepository: UserRepository;

	@UseMiddleware(yupValidateMiddleware(YUP_REGISTER))
	@Mutation(() => ErrorMessage!, { nullable: true })
	async register(
		@Arg("data") { email, firstName, lastName, password }: RegisterDto
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
