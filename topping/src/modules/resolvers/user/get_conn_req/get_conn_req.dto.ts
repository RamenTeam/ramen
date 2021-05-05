import { Field, InputType } from "type-graphql";
@InputType()
export class GetConnectionRequestDto {
	@Field()
	userId: string;
}
