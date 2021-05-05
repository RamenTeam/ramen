import { Field, InputType } from "type-graphql";

@InputType()
export class AcceptConnectionRequestDto {
	@Field()
	connectionId: string;
}
