import { Field, InputType } from "type-graphql";
@InputType()
export class ForgotPasswordChangeDto {
	@Field()
	key: string;

	@Field()
	newPassword: string;
}
