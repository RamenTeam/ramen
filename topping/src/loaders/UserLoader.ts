import * as DataLoader from "dataloader";
import { User } from "../entity/User";

/** For dataloader and batching
 * - We need a set of users in a format as
 *
 *   1 : {...}
 *   2 : {...}
 *   ...
 *
 */

type BatchUsers = (ids: string[]) => Promise<User[]>;

const batchUsers: BatchUsers = async (ids) => {
	const users: User[] = await User.findByIds(ids, {
		relations: ["connections"],
	});

	const userMap: { [key: string]: User } = {};

	users.forEach((user) => (userMap[user.id] = user));

	return ids.map((id) => userMap[id]);
};

export const userLoader = () =>
	new DataLoader<string, User>((keys) => batchUsers([...keys]));
