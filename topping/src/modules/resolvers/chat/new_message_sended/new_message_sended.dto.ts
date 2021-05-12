import { Field, InputType } from "type-graphql";

@InputType()
export class NewMessageSendedDto {
	@Field()
	conversationId: string;
}
