import { testFrame } from "../../../../test-utils/testFrame";
import { TestClient } from "../../../../test-utils/TestClient";
import * as faker from "faker";
import { yupErrorResponse } from "../../../../test-utils/yupErrorResponse";
import { User } from "../../../../entity/User";
import { v4 as uuidV4 } from "uuid";
import { RegisterDto } from "../register/register.dto";

let client: TestClient | null = null;

const mockData: RegisterDto = {
	email: faker.internet.email(),
	password: faker.internet.password(),
	firstName: faker.internet.userName(),
	lastName: faker.internet.userName(),
	username: faker.internet.userName(),
	phoneNumber: "9798678564",
	bio: "",
};

testFrame(() => {
	beforeAll(async () => {
		client = new TestClient();
	});

	describe("Get users test suite", () => {
		test("should be invalid id", async () => {
			await client?.user
				.getUser({
					userId: "123",
				})
				.then((res) => {
					expect(yupErrorResponse(res)).toEqual([
						{
							message: "userId must be a valid UUID",
							path: "userId",
						},
					]);
				});
		});

		test("should not be found", async () => {
			await client?.user
				.getUser({
					userId: await uuidV4(),
				})
				.then((res) => {
					expect(res.getUser).toBeNull();
				});
		});

		test("should return user", async () => {
			const user = await User.create(mockData).save();
			await client?.user
				.getUser({
					userId: user.id,
				})
				.then((res) => {
					expect(res.getUser).toStrictEqual({
						email: mockData.email,
						firstName: mockData.firstName,
						id: user.id,
						lastName: mockData.lastName,
						name: `${mockData.firstName} ${mockData.lastName}`,
						password: user.password,
						status: user.status,
						isVerified: false,
						username: mockData.username,
						isBanned: false,
						phoneNumber: mockData.phoneNumber,
						forgotPasswordLock: false,
						bio: "",
					});
				});
		});
	});
});
