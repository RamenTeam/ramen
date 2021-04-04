import { Field, InputType } from "type-graphql";

@InputType()
export class LoginDto {
	@Field()
	email: string;

	@Field()
	password: string;
}
