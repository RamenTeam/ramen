import * as yup from "yup";
import { sharedSchema } from "../../../../shared/yupSchema";

export const YUP_CHANGE_PASSWORD = yup.object().shape({
	key: yup.string(),
	newPassword: sharedSchema.password,
});
