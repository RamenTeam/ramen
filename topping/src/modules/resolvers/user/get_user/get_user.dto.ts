import { Field, InputType } from "type-graphql";
@InputType()
export class GetUserDto {
	@Field()
	userId: string;
}
