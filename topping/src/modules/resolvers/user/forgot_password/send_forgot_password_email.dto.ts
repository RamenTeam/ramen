import { Field, InputType } from "type-graphql";
@InputType()
export class ForgotPasswordDto {
	@Field()
	email: string;
}
