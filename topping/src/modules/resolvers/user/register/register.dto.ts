import { Field, InputType } from "type-graphql";
import * as yup from "yup";
import { sharedSchema } from "../../../../shared/yupSchema";

@InputType()
export class RegisterDto {
	@Field()
	firstName: string;

	@Field()
	lastName: string;

	@Field()
	email: string;

	@Field()
	password: string;
}

export const YUP_REGISTER = yup.object().shape({
	firstName: yup.string().min(3).max(255),
	lastName: yup.string().min(3).max(255),
	email: sharedSchema.email,
	password: sharedSchema.password,
});
