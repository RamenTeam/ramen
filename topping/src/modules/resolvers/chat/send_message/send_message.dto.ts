import { Field, InputType } from "type-graphql";

@InputType()
export class SendMessageDto {
	@Field()
	conversationId: string;

	@Field()
	message: string;
}
