import { Field, InputType } from "type-graphql";

@InputType()
class UpdateProfileDto {
	@Field({ nullable: true })
	firstName?: string;

	@Field({ nullable: true })
	lastName?: string;

	@Field({ nullable: true })
	username?: string;

	@Field({ nullable: true })
	email?: string;

	@Field({ nullable: true })
	bio?: string;

	@Field({ nullable: true })
	password?: string;

	@Field({ nullable: true })
	phoneNumber?: string;

	@Field({ nullable: true })
	avatarPath?: string;
}

export default UpdateProfileDto;
