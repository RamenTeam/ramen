import { Field, InputType } from "type-graphql";
import * as yup from "yup";
@InputType()
export class CreateDirectConversationDto {
	@Field()
	toId: string;
}

export const YUP_DIRECT_CONVERSATION_CREATE = yup.object().shape({
	toId: yup.string().uuid(`Your id is not an uuid`),
});
