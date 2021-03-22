import { testFrame } from "../../../../test-utils/testFrame";
import { TestClient } from "../../../../test-utils/TestClient";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";
import { yupErrorResponse } from "../../../../test-utils/yupErrorResponse";
import * as faker from "faker";
import { getRepository } from "typeorm";
import { User } from "../../../../entity/User";
import * as bcrypt from "bcrypt";

let client: TestClient | null = null;

const mockData = {
	email: faker.internet.email(),
	password: faker.internet.password(),
	firstName: faker.internet.userName(),
	lastName: faker.internet.userName(),
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

			expect(user).toBeDefined();
			expect({
				email: user?.email,
				firstName: user?.firstName,
				lastName: user?.lastName,
			}).toStrictEqual({
				email: mockData.email,
				firstName: mockData.firstName,
				lastName: mockData.lastName,
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
		test("account is registered", async () => {
			const data = await client?.user.register(mockData);
			expect(data.register).toMatchObject({
				message: CustomMessage.emailIsRegister,
				path: "email",
			});
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

		test("[Yup] firstName & lastName length match", async () => {
			const data = await client?.user.register({
				email: faker.internet.email(),
				password: faker.internet.password(),
				firstName: "",
				lastName: "",
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
	});
});
