import { Redis } from "ioredis";
import * as nodemailer from "nodemailer";
import { v4 } from "uuid";
import {
	EMAIL_CONFIRM_PREFIX,
	FORGOT_PASSWORD_PREFIX,
} from "../constants/global-variables";
import { EmailService } from "./i_email";

export default class NodeMailerService implements EmailService {
	async sendEmail(to: string, subject: string, text: string) {
		// let testAccount = await nodemailer.createTestAccount();

		// logger.info(testAccount);

		const AUTH_ACCOUNT: { user: any; pass: any } = {
			user: "vpo3nwkyqxtwvxzc@ethereal.email",
			pass: "4r4kp4hAyzGsKcquRg",
		};

		let transporter = nodemailer.createTransport({
			host: "smtp.ethereal.email",
			port: 587,
			secure: false, // true for 465, false for other ports
			auth: {
				user: AUTH_ACCOUNT.user, // generated ethereal user
				pass: AUTH_ACCOUNT.pass, // generated ethereal password
			},
			tls: {
				rejectUnauthorized: false,
			},
		});

		let info = await transporter.sendMail({
			from: `"Ramen Cook 🍜" <${AUTH_ACCOUNT.user}>`, // sender address
			to, // list of receivers
			subject, // Subject line
			text, // plain text body
		});

		console.log("Message sent: %s", info.messageId);

		console.log("Preview URL: %s", nodemailer.getTestMessageUrl(info));
	}

	async createConfirmedEmailLink(url: string, userId: string, redis: Redis) {
		const id = v4();
		//Disable all the login access while forgotPassword process is running
		await redis.set(`${EMAIL_CONFIRM_PREFIX}${id}`, userId, "ex", 60 * 20);
		return `${url}/confirm/${id}`;
	}

	async createForgotPasswordLink(url: string, userId: string, redis: Redis) {
		const id = v4();
		// Set the forgot password in the IMDB to avoid keep login while forgotPassword
		await redis.set(`${FORGOT_PASSWORD_PREFIX}${id}`, userId, "ex", 60 * 20);
		return `${url}/change-password/${id}`;
	}
}
