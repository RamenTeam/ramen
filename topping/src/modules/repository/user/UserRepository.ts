import { EntityRepository, Repository } from "typeorm";
import { User } from "../../../entity/User";
import { BlackList } from "../../../entity/BlackList";

@EntityRepository(User)
export class UserRepository extends Repository<User> {
	async findByEmail(email: string | undefined) {
		return await this.findOne({ where: { email } });
	}

	async findByUsername(username: string | undefined) {
		return await this.findOne({ where: { username } });
	}

	async findByPhoneNumber(phoneNumber: string | undefined) {
		return await this.findOne({
			where: {
				phoneNumber,
			},
		});
	}

	async checkBanned(phoneNumber: string | undefined) {
		const isInBlackList = await BlackList.findOneOrFail({
			where: {
				phoneNumber,
			},
		});

		return isInBlackList;
	}

	updateFollow(user: User) {
		return (following: User) => {
			user.following.push(following);
			following.followers.push(user);
		};
	}
}
