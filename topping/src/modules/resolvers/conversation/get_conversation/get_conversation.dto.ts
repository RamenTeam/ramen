import { Field, InputType } from "type-graphql";
import * as yup from "yup";
@InputType()
export class GetConversationDto {
	@Field()
	conversationId: string;
}

export const YUP_CONVERSATION_READ = yup.object().shape({
	conversationId: yup.string().uuid(),
});
