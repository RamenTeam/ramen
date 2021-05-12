import { Field, InputType } from "type-graphql";
@InputType()
export class GetConnectionDto {
	@Field()
	userId: string;
}
