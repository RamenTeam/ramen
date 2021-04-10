import { testFrame } from "../../../../test-utils/testFrame";
import { TestClient } from "../../../../test-utils/TestClient";
import { yupErrorResponse } from "../../../../test-utils/yupErrorResponse";
import * as faker from "faker";
import { User } from "../../../../entity/User";
import { getRepository } from "typeorm";
import { RegisterDto } from "../register/register.dto";

let client: TestClient | null = null;

const mockData: RegisterDto = {
	email: faker.internet.email(),
	password: faker.internet.password(),
	firstName: faker.internet.userName(),
	lastName: faker.internet.userName(),
	username: faker.internet.userName(),
	phoneNumber: "091723127312",
	bio: "",
};

testFrame(() => {
	beforeAll(async () => {
		client = new TestClient();
		await getRepository(User)
			.create({
				...mockData,
				isVerified: true,
			})
			.save();
	});

	describe("Me test suite", () => {
		test("get current user before login", async () => {
			await client?.user.me().then((res) =>
				expect(yupErrorResponse(res)).toMatchObject([
					{
						message: "not authenticated",
						path: "me",
					},
				])
			);
		});
		test("get current user after login", async () => {
			await client?.user
				.login({
					email: mockData.email,
					password: mockData.password,
				})
				.then((res) => expect(res.login).toBeNull());
			const user = await getRepository(User).findOne({
				where: {
					email: mockData.email,
				},
			});
			await client?.user.me().then((res) =>
				expect(res.me).toStrictEqual({
					email: mockData.email,
					firstName: mockData.firstName,
					id: user?.id,
					isVerified: true,
					lastName: mockData.lastName,
					name: `${mockData.firstName} ${mockData.lastName}`,
					password: user?.password,
					status: user?.status,
					username: mockData.username,
					isBanned: false,
					phoneNumber: mockData.phoneNumber,
					forgotPasswordLock: false,
					bio: "",
				})
			);
		});
	});
});
