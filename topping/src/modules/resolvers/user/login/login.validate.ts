import * as yup from "yup";
import { sharedSchema } from "../../../../shared/yupSchema";

export const YUP_LOGIN = yup.object().shape({
	email: sharedSchema.email,
	password: sharedSchema.password,
});
