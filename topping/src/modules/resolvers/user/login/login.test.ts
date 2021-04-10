import { testFrame } from "../../../../test-utils/testFrame";
import { TestClient } from "../../../../test-utils/TestClient";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";
import { yupErrorResponse } from "../../../../test-utils/yupErrorResponse";
import * as faker from "faker";
import { RegisterDto } from "../register/register.dto";
import { getRepository } from "typeorm";
import { User } from "../../../../entity/User";
import { ErrorMessage } from "../../../../shared/ErrorMessage.type";

let client1: TestClient | null = null;

let client2: TestClient | null = null;

const mockData: RegisterDto = {
	email: faker.internet.email(),
	password: faker.internet.password(),
	firstName: faker.internet.userName(),
	lastName: faker.internet.userName(),
	username: faker.internet.userName(),
	phoneNumber: faker.phone.phoneNumber(),
	bio: "",
};

testFrame(() => {
	beforeAll(async () => {
		client1 = new TestClient();

		client2 = new TestClient();

		await client1.user.register(mockData);
	});

	describe("Login test suite", () => {
		test("account is not verified", async () => {
			await client1?.user
				.login({ email: mockData.email, password: mockData.password })
				.then((res) =>
					expect(res.login).toEqual({
						message: CustomMessage.userIsNotVerified,
						path: "isVerified",
					})
				);
		});
		test("verify account", async () => {
			await getRepository(User).update(
				{ email: mockData.email },
				{ isVerified: true }
			);

			await getRepository(User)
				.findOne({ where: { email: mockData.email } })
				.then((res) =>
					expect(res).toMatchObject({
						isVerified: true,
					})
				);
		});

		test("account is banned", async () => {
			const tempData = {
				email: faker.internet.email(),
				password: faker.internet.password(),
				firstName: faker.internet.userName(),
				lastName: faker.internet.userName(),
				username: faker.internet.userName(),
				phoneNumber: faker.phone.phoneNumber(),
				bio: "",
			};
			await client1?.user.register(tempData);
			await getRepository(User).update(
				{
					email: tempData.email,
				},
				{
					isVerified: true,
					isBanned: true,
				}
			);
			await client1?.user
				.login({ email: tempData.email, password: tempData.password })
				.then((res) =>
					expect(res.login).toStrictEqual({
						message: CustomMessage.userIsBanned,
						path: "isBanned",
					})
				);
		});

		test("account is not register", async () => {
			await client1?.user
				.login({
					email: "tin@email.com",
					password: "123456",
				})
				.then((res) =>
					expect(res).toStrictEqual({
						login: {
							message: CustomMessage.accountIsNotRegister,
							path: "email",
						},
					})
				);
		});

		test("[Yup] invalid email address", async () => {
			const data = await client1?.user.login({
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
			const data = await client1?.user.login({
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
			const data = await client1?.user.login({
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
			const data = await client1?.user.login({
				email: mockData.email,
				password: mockData.password + "123",
			});
			expect(data.login).toMatchObject({
				message: CustomMessage.passwordIsNotMatch,
				path: "password",
			});
		});

		test("account is not registered", async () => {
			const data = await client1?.user.login({
				email: faker.internet.email(),
				password: mockData.password,
			});
			expect(data.login).toMatchObject({
				message: CustomMessage.accountIsNotRegister,
				path: "email",
			});
		});

		test("get user before login", async () => {
			const me = await client1?.user.me();
			expect(yupErrorResponse(me)).toEqual([
				{ message: "not authenticated", path: "me" },
			]);
		});

		test("login works", async () => {
			const data = await client1?.user.login({
				email: mockData.email,
				password: mockData.password,
			});
			expect(data.login).toBeNull();
		});

		test(CustomMessage.userHasLoggedIn, async () => {
			await client1?.user
				.login({
					email: mockData.email,
					password: mockData.password,
				})
				.then((res) =>
					expect(res.login).toMatchObject({
						message: CustomMessage.userHasLoggedIn,
						path: "login",
					})
				);
		});

		test("Multi session login works", async () => {
			await client2?.user
				.login({
					email: mockData.email,
					password: mockData.password,
				})
				.then((res) => expect(res.login).toBeNull());
		});
	});
});
