import { testFrame } from "../../../../test-utils/testFrame";
import { TestClient } from "../../../../test-utils/TestClient";
import { yupErrorResponse } from "../../../../test-utils/yupErrorResponse";
import * as faker from "faker";
import { RegisterDto } from "../register/register.dto";

let client: TestClient | null = null;

const mockData: RegisterDto = {
	email: faker.internet.email(),
	password: faker.internet.password(),
	firstName: faker.internet.userName(),
	lastName: faker.internet.userName(),
	username: faker.internet.userName(),
};

testFrame(() => {
	beforeAll(async () => {
		client = new TestClient();
		await client.user.register(mockData);
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
