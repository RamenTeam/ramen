import { Error } from "../modules/common/error.schema";
import { formatYupErrors } from "./formatYupErrors";

export const formatValidationError = (err: any): any[] => {
	const validationErrors: any[] = err.extensions?.exception?.validationErrors;
	console.log(JSON.stringify(err, null, 2));
	const errors: Error[] = [];
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
