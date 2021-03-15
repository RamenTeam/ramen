import { GraphQLClient, request } from "graphql-request";
import * as rp from "request-promise";
import crossFetch from "cross-fetch";
import * as GQLModules from "../modules/graphql";
import { LoginDto } from "../modules/resolvers/user/login/login.dto";
import { RegisterDto } from "../modules/resolvers/user/register/register.dto";
interface GQL {
	mutations: any;
	queries: any;
	subscription: any;
}

const GQL: GQL = GQLModules;
export class TestClient {
	client: GraphQLClient;

	constructor(url: string) {
		const fetch = require("fetch-cookie")(crossFetch);
		this.client = new GraphQLClient(url, {
			credentials: "include",
			mode: "cors",
			fetch,
		});
	}

	async mutation<T>(resolver: string, args: T) {
		return await this.client
			.request(GQL.mutations[resolver], { data: args })
			.then((data) => data)
			.catch((err) => err);
	}

	async query(resolver: string) {
		return await this.client
			.request(GQL.queries[resolver])
			.then((data) => data)
			.catch((err) => err);
	}

	login = async (args: LoginDto) =>
		await this.mutation<LoginDto>("login", args);

	register = async (args: RegisterDto) =>
		await this.mutation<RegisterDto>("register", args);

	me = async () => await this.query("me");

	logout = async () => await this.mutation("logout", null);
}
