import { Field, ObjectType } from "type-graphql";

@ObjectType()
export class ErrorMessage {
	@Field()
	path: string;

	@Field()
	message: string;
}
