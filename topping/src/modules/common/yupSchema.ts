import * as yup from "yup";

const sharedSchema = {
	email: yup.string().email(),
	password: yup.string().min(3).max(255),
};

export const YUP_LOGIN = yup.object().shape({
	email: sharedSchema.email,
	password: sharedSchema.password,
});

export const YUP_REGISTER = yup.object().shape({
	firstName: yup.string().min(3).max(255),
	lastName: yup.string().min(3).max(255),
	email: sharedSchema.email,
	password: sharedSchema.password,
});

export const YUP_CONVERSATION_CRUD = yup.object().shape({
	name: yup.string().min(1).max(30),
});

export const YUP_UUID = yup.object().shape({
	id: yup.string().uuid(`Your id is not an uuid`),
});
