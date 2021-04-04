import { Redis } from "ioredis";

export interface EmailService {
	sendEmail(to: string, subject: string, text: string);
	createConfirmedEmailLink(url: string, userId: string, redis: Redis);
	createForgotPasswordLink(url: string, userId: string, redis: Redis);
}
