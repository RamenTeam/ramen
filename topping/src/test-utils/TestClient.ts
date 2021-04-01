import { GraphQLClient } from "graphql-request";
import crossFetch from "cross-fetch";
import * as GQLModules from "../modules/graphql";
import { LoginDto } from "../modules/resolvers/user/login/login.dto";
import { RegisterDto } from "../modules/resolvers/user/register/register.dto";
import { GetUserDto } from "../modules/resolvers/user/get_user/get_user.dto";
interface GQL {
	mutations: any;
	queries: any;
	subscription: any;
}

const GQL: GQL = GQLModules;
export class TestClient {
	private client: GraphQLClient;

	constructor() {
		const fetch = require("fetch-cookie")(crossFetch);
		this.client = new GraphQLClient("http://localhost:8080/graphql", {
			credentials: "include",
			mode: "cors",
			fetch,
		});
	}

	private async mutation<T>(resolver: string, args: T) {
		return await this.client
			.request(GQL.mutations[resolver], { data: args })
			.then((data) => data)
			.catch((err) => err);
	}

	private async query<T>(resolver: string, args?: T) {
		return await this.client
			.request(GQL.queries[resolver], args && { data: args })
			.then((data) => data)
			.catch((err) => err);
	}

	user = {
		login: async (args: LoginDto) =>
			await this.mutation<LoginDto>("login", args),

		register: async (args: RegisterDto) =>
			await this.mutation<RegisterDto>("register", args),

		me: async () => await this.query("me"),

		logout: async () => await this.mutation("logout", null),

		getUser: async (args: GetUserDto) =>
			await this.query<GetUserDto>("getUser", args),

		getUsers: async () => await this.query("getUsers"),
	};
}
