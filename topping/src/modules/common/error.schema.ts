import { Field, ObjectType } from "type-graphql";

@ObjectType()
export class Error {
	@Field()
	path: string;

	@Field()
	message: string;
}
