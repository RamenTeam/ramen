import { Redis } from "ioredis";
import { Db } from "mongodb";

export interface EmailService {
	sendEmail(to: string, subject: string, text: string);
	createConfirmedEmailLink(url: string, userId: string, mongodb: Db);
	createForgotPasswordLink(url: string, userId: string, mongodb: Db);
}
