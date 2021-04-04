import { Field, InputType } from "type-graphql";
import * as yup from "yup";
@InputType()
export class ForgotPasswordDto {
	@Field()
	email: string;
}

export const YUP_FORGOT_PASSWORD = yup.object().shape({
	email: yup.string().email(),
});
