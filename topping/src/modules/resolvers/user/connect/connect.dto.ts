import { Field, InputType } from "type-graphql";
@InputType()
export class ConnectUserDto {
	@Field()
	userId: string;
}
