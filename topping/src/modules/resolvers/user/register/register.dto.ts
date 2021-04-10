import { Field, InputType } from "type-graphql";

@InputType()
export class RegisterDto {
	@Field()
	firstName: string;

	@Field()
	lastName: string;

	@Field()
	username: string;

	@Field()
	email: string;

	@Field()
	bio: string;

	@Field()
	password: string;

	@Field()
	phoneNumber: string;
}
