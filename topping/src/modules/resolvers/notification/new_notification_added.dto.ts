import { Field, InputType } from "type-graphql";

@InputType()
class NewNotificationAddedDto {
	@Field(() => String)
	userId: String;
}

export default NewNotificationAddedDto;
