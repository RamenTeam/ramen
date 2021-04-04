import { EntityRepository, Repository } from "typeorm";
import { User } from "../../../entity/User";

@EntityRepository(User)
export class UserRepository extends Repository<User> {
	async findByEmail(email: string | undefined) {
		return await this.findOne({ where: { email } });
	}

	async findByUsername(username: string | undefined) {
		return await this.findOne({ where: { username } });
	}

	async findByPhoneNumber(phoneNumber: string | undefined) {
		return await this.findOne({ where: {} }); //TODO phonenumber find
	}
}
