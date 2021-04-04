import * as yup from "yup";

export const YUP_SEND_FORGOT_PASSWORD_EMAIL = yup.object().shape({
	email: yup.string().email(),
});
