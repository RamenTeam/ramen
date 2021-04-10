import { testFrame } from "../../../../test-utils/testFrame";
import { TestClient } from "../../../../test-utils/TestClient";
import { yupErrorResponse } from "../../../../test-utils/yupErrorResponse";
import * as faker from "faker";
import { RegisterDto } from "../register/register.dto";
import { getRepository } from "typeorm";
import { User } from "../../../../entity/User";

let client: TestClient | null = null;

const mockData: RegisterDto = {
	email: faker.internet.email(),
	password: faker.internet.password(),
	firstName: faker.internet.userName(),
	lastName: faker.internet.userName(),
	username: faker.internet.userName(),
	phoneNumber: "1236187246",
	bio: "",
};

testFrame(() => {
	beforeAll(async () => {
		client = new TestClient();
		await getRepository(User)
			.create({ ...mockData, isVerified: true })
			.save();
	});

	describe("Logout test suite", () => {
		test("logout before login", async () => {
			await client?.user.logout().then((res) =>
				expect(yupErrorResponse(res)).toMatchObject([
					{
						message: "not authenticated",
						path: "logout",
					},
				])
			);
		});

		test("login to account", async () => {
			await client?.user
				.login({ email: mockData.email, password: mockData.password })
				.then((res) => expect(res.login).toBeNull());
		});

		test("logout works", async () => {
			await client?.user.logout().then((res) => expect(res.logout).toBeNull);

			await client?.user.me().then((res) =>
				expect(yupErrorResponse(res)).toMatchObject([
					{
						message: "not authenticated",
						path: "me",
					},
				])
			);
		});
	});
});
