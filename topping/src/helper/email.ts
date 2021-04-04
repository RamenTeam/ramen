import * as nodemailer from "nodemailer";
import { logger } from "../config/winston.config";
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
}
