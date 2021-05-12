import { EntityRepository, Repository } from "typeorm";
import { User } from "../../entity/User";
import { BlackList } from "../../entity/BlackList";
import { Conversation } from "../../entity/Conversation";

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

	updateConnection(user: User) {
		return (connector: User) => {
			user.connections.push(connector);
			connector.connections.push(user);
		};
	}

	async findUserAndUpdateConversation(user: User, conversation: Conversation) {
		user?.conversations.push(conversation);
	}
}
