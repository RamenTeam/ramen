import * as faker from "faker";
import { User } from "../../../../entity/User";
import { CustomMessage } from "../../../../shared/CustomMessage.enum";
import { TestClient } from "../../../../test-utils/TestClient";
import { testFrame } from "../../../../test-utils/testFrame";
import { RegisterDto } from "../register/register.dto";

let client: TestClient | null = null;
let user: User | null = null;

const mockData: RegisterDto = {
	email: faker.internet.email(),
	password: faker.internet.password(),
	firstName: faker.internet.userName(),
	lastName: faker.internet.userName(),
	username: faker.internet.userName(),
	phoneNumber: "123456789123",
	bio: "",
};

testFrame(() => {
	beforeAll(async () => {
		client = new TestClient();

		user = await User.create(mockData).save();
	});

	describe("Send forgot password test suite", () => {
		test("user is not found", async () => {
			const res = await client?.user.sendForgotPasswordEmail({
				email: faker.internet.email(),
			});

			expect(res.sendForgotPasswordEmail).toMatchObject({
				message: CustomMessage.userIsNotFound,
				path: "email",
			});
		});

		test("send email works", async () => {
			const res = await client?.user.sendForgotPasswordEmail({
				email: mockData.email,
			});

			expect(res.sendForgotPasswordEmail).toBeNull();

			expect(user?.forgotPasswordLock).toBe(true);
		});
	});
	//TODO test password lock
	// describe("Forgot password change test suite", () => {});
});
