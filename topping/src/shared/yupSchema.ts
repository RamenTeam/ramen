import * as yup from "yup";
import { CustomMessage } from "./CustomMessage.enum";

export const sharedSchema = {
	email: yup.string().email(CustomMessage.inValidEmailAddress),
	password: yup.string().min(3).max(255),
};

export const YUP_UUID = yup.object().shape({
	id: yup.string().uuid(`Your id is not an uuid`),
});
