import { testFrame } from "../../../../test-utils/testFrame";
import { TestClient } from "../../../../test-utils/TestClient";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";
import { yupErrorResponse } from "../../../../test-utils/yupErrorResponse";
import * as faker from "faker";
import { getRepository } from "typeorm";
import { User } from "../../../../entity/User";
import * as bcrypt from "bcrypt";
import { RegisterDto } from "./register.dto";

let client: TestClient | null = null;

const mockData: RegisterDto = {
	email: faker.internet.email(),
	password: faker.internet.password(),
	firstName: faker.internet.userName(),
	lastName: faker.internet.userName(),
	username: faker.internet.userName(),
	phoneNumber: "123456789123",
	bio: "1".repeat(130),
};

testFrame(() => {
	beforeAll(async () => {
		client = new TestClient();
	});

	describe("Register test suite", () => {
		test("register works", async () => {
			const data = await client?.user.register(mockData);

			expect(data.register).toBeNull();

			const user = await getRepository(User).findOne({
				where: {
					email: mockData.email,
				},
			});

			await getRepository(User).update(
				{
					email: mockData.email,
				},
				{
					isVerified: true,
				}
			);

			expect(user).toBeDefined();

			expect({
				email: user?.email,
				firstName: user?.firstName,
				lastName: user?.lastName,
				username: user?.username,
				phoneNumber: user?.phoneNumber,
			}).toStrictEqual({
				email: mockData.email,
				firstName: mockData.firstName,
				lastName: mockData.lastName,
				username: user?.username,
				phoneNumber: user?.phoneNumber,
			});
			const isPasswordMatched = await bcrypt.compare(
				mockData.password,
				user?.password as string
			);
			expect(isPasswordMatched).toBe(true);
		});

		test("login to registered account", async () => {
			const data = await client?.user.login({
				email: mockData.email,
				password: mockData.password,
			});
			expect(data.login).toBeNull();
		});

		test("[Yup] email is not valid", async () => {
			const data = await client?.user.register({
				...mockData,
				email: "tin",
			});
			expect(yupErrorResponse(data)).toEqual([
				{
					message: CustomMessage.inValidEmailAddress,
					path: "email",
				},
			]);
		});

		test("[Yup] password length matched", async () => {
			const data = await client?.user.register({
				...mockData,
				email: faker.internet.email(),
				password: "1",
			});
			expect(yupErrorResponse(data)).toEqual([
				{
					message: "password must be at least 3 characters",
					path: "password",
				},
			]);
		});

		test("[Yup] username length matched", async () => {
			await client?.user
				.register({
					...mockData,
					email: faker.internet.email(),
					username: "123",
				})
				.then((res) =>
					expect(yupErrorResponse(res)).toEqual([
						{
							message: "username must be at least 4 characters",
							path: "username",
						},
					])
				);

			await client?.user
				.register({
					...mockData,
					email: faker.internet.email(),
					username: "1".repeat(50),
				})
				.then((res) =>
					expect(yupErrorResponse(res)).toEqual([
						{
							message: "username must be at most 20 characters",
							path: "username",
						},
					])
				);
		});

		test("[Yup] firstName & lastName length match", async () => {
			const data = await client?.user.register({
				email: faker.internet.email(),
				password: faker.internet.password(),
				firstName: "",
				lastName: "",
				username: "tin123",
				phoneNumber: "1231231231",
				bio: "1".repeat(130),
			});
			expect(yupErrorResponse(data)).toEqual([
				{
					message: "firstName must be at least 3 characters",
					path: "firstName",
				},
				{
					message: "lastName must be at least 3 characters",
					path: "lastName",
				},
			]);
		});

		test("[Yup] phoneNumber length match", async () => {
			const data = await client?.user.register({
				...mockData,
				email: faker.internet.email(),
				username: faker.internet.userName(),
				phoneNumber: "1".repeat(30),
			});
			expect(yupErrorResponse(data)).toEqual([
				{
					message: "phoneNumber must be at most 20 characters",
					path: "phoneNumber",
				},
			]);
		});

		test("[Yup] username has been taken", async () => {
			const data = await client?.user.register({
				...mockData,
				phoneNumber: "89831286312",
				email: faker.internet.email(),
			});
			expect(data.register).toEqual({
				message: CustomMessage.usernameIsTaken,
				path: "username",
			});
		});

		test("[Yup] phoneNumber has been taken", async () => {
			const data = await client?.user.register({
				...mockData,
				username: faker.internet.userName(),
				email: faker.internet.email(),
			});
			expect(data.register).toEqual({
				message: CustomMessage.phoneNumberIsTaken,
				path: "phoneNumber",
			});
		});
	});
});
