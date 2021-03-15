import { ErrorMessage } from "../shared/ErrorMessage.type";
import { formatYupErrors } from "./formatYupErrors";

export const formatValidationError = (err: any): any[] => {
	const validationErrors: any[] = err.extensions?.exception?.validationErrors;
	const errors: ErrorMessage[] = [];
	if (err.message?.name == "ValidationError") {
		return formatYupErrors(err.message);
	} else {
		if (validationErrors) {
			validationErrors?.forEach(({ constraints }) => {
				errors.push({
					path: Object.keys(constraints)?.[0],
					message: constraints[Object.keys(constraints)?.[0]],
				});
			});
		} else {
			errors.push({
				path: err.path?.[0] || "undefined",
				message: err.message,
			});
		}
		return errors;
	}
};
