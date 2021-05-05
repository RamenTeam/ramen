import { Field, InputType } from "type-graphql";

@InputType()
export class RejectConnectionRequest {
	@Field()
	connectionId: string;
}
