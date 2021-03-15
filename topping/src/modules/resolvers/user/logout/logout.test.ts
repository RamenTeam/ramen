import { testFrame } from "../../../../test-utils/testFrame";
import { TestClient } from "../../../../test-utils/TestClient";
import { yupErrorResponse } from "../../../../test-utils/yupErrorResponse";
import * as faker from "faker";

let client: TestClient | null = null;

const mockData = {
	email: faker.internet.email(),
	password: faker.internet.password(),
	firstName: faker.internet.userName(),
	lastName: faker.internet.userName(),
};

testFrame(() => {
	beforeAll(async () => {
		client = new TestClient("http://localhost:5000/graphql");
		await client.register(mockData);
	});

	describe("Logout test suite", () => {
		test("logout before login", async () => {
			await client?.logout().then((res) =>
				expect(yupErrorResponse(res)).toMatchObject([
					{
						message: "not authenticated",
						path: "logout",
					},
				])
			);
		});

		test("login to account", async () => {
			await client
				?.login({ email: mockData.email, password: mockData.password })
				.then((res) => expect(res.login).toBeNull());
		});

		test("logout works", async () => {
			await client?.logout().then((res) => expect(res.logout).toBeNull);

			await client?.me().then((res) =>
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
