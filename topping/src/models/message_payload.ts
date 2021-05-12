import { Field, ObjectType } from "type-graphql";

@ObjectType("MessagePayloadSchema")
export class MessagePayload {
	@Field(() => String!)
	messageId: String;

	@Field(() => String!)
	conversationId: String;
}
