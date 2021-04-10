import * as yup from "yup";
import { sharedSchema } from "../../../../shared/yupSchema";

export const YUP_REGISTER = yup.object().shape({
	firstName: yup.string().min(3).max(255),
	lastName: yup.string().min(3).max(255),
	email: sharedSchema.email,
	password: sharedSchema.password,
	username: yup.string().min(4).max(20),
	phoneNumber: yup.string().max(20),
	bio: yup.string().max(150)
});
