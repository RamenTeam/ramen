import { ValidationError } from "yup";

export const formatYupErrors = (err: ValidationError) => {
	const errors: Array<{ path: string | undefined; message: string }> = [];
	err.inner.forEach((e) => {
		errors.push({
			path: e.path,
			message: e.message,
		});
	});
	return errors;
};
