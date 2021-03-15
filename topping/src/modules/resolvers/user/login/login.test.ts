import { testFrame } from "../../../../test-utils/testFrame";
import { TestClient } from "../../../../test-utils/TestClient";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";
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

	describe("Login test suite", () => {
		test("account is not register", async () => {
			expect(
				await client?.login({
					email: "tin@email.com",
					password: "123",
				})
			).toEqual({
				login: {
					message: CustomMessage.accountIsNotRegister,
					path: "email",
				},
			});
		});

		test("[Yup] invalid email address", async () => {
			const data = await client?.login({
				email: "tin",
				password: "123",
			});
			expect(yupErrorResponse(data)).toEqual([
				{
					message: CustomMessage.inValidEmailAddress,
					path: "email",
				},
			]);
		});

		test("[Yup]password length matched", async () => {
			const data = await client?.login({
				email: "tin@email.com",
				password: "1",
			});
			expect(yupErrorResponse(data)).toEqual([
				{
					message: "password must be at least 3 characters",
					path: "password",
				},
			]);
		});

		test("[Yup] invalid email address & password length matched", async () => {
			const data = await client?.login({
				email: "tin",
				password: "1",
			});
			expect(yupErrorResponse(data)).toEqual([
				{
					message: CustomMessage.inValidEmailAddress,
					path: "email",
				},
				{
					message: "password must be at least 3 characters",
					path: "password",
				},
			]);
		});

		test("password does not matched", async () => {
			const data = await client?.login({
				email: mockData.email,
				password: mockData.password + "123",
			});
			expect(data.login).toMatchObject({
				message: CustomMessage.passwordIsNotMatch,
				path: "password",
			});
		});

		test("account is not registered", async () => {
			const data = await client?.login({
				email: faker.internet.email(),
				password: mockData.password,
			});
			expect(data.login).toMatchObject({
				message: CustomMessage.accountIsNotRegister,
				path: "email",
			});
		});

		test("get user before login", async () => {
			const me = await client?.me();
			expect(yupErrorResponse(me)).toEqual([
				{ message: "not authenticated", path: "me" },
			]);
		});

		test("login works", async () => {
			const data = await client?.login({
				email: mockData.email,
				password: mockData.password,
			});
			expect(data.login).toBeNull();
		});
	});
});
