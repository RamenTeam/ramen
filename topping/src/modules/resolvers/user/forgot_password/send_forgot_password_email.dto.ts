import { Field, InputType } from "type-graphql";
@InputType()
export class SendForgotPasswordDto {
	@Field()
	email: string;
}
