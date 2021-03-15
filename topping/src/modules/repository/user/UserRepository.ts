import { EntityRepository, Repository } from "typeorm";
import { User } from "../../../entity/User";
import { CustomMessage } from "../../../shared/CustomMessage.enum";

@EntityRepository(User)
export class UserRepository extends Repository<User> {
	async findByEmail(email: string | undefined) {
		return await this.findOne({ where: { email } });
	}
	async findByEmailOrCreate({
		email,
		firstName,
		lastName,
		password,
	}: Partial<User>) {
		const user = await this.findByEmail(email);
		if (!!user) {
			return {
				path: "email",
				message: CustomMessage.emailIsRegister,
			};
		}
		await this.create({
			email,
			password,
			firstName,
			lastName,
		})
			.save()
			.then((err) => console.log(err));

		return null;
	}
}
