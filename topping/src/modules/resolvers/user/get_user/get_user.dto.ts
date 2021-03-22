import { Field, InputType } from "type-graphql";
import * as yup from "yup";
@InputType()
export class GetUserDto {
	@Field()
	userId: string;
}

export const YUP_USER_READ = yup.object().shape({
	userId: yup.string().uuid(),
});
