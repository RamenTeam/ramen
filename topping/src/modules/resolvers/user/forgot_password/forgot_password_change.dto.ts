import { Field, InputType } from "type-graphql";
@InputType()
export class ChangePasswordDto {
	@Field()
	key: string;

	@Field()
	newPassword: string;
}
