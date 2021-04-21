import { Field, InputType } from "type-graphql";
@InputType()
export class FollowUserDto {
	@Field()
	userId: string;
}
