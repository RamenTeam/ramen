import * as yup from "yup";

export const YUP_USER_READ = yup.object().shape({
	userId: yup.string().uuid(),
});
