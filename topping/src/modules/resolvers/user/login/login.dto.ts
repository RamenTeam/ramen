import { Field, InputType } from "type-graphql";
import * as yup from "yup";
import { sharedSchema } from "../../../../shared/yupSchema";

@InputType()
export class LoginDto {
	@Field()
	email: string;

	@Field()
	password: string;
}

export const YUP_LOGIN = yup.object().shape({
	email: sharedSchema.email,
	password: sharedSchema.password,
});
