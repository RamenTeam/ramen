import * as nodemailer from "nodemailer";
import { logger } from "../config/winston.config";
import { EmailService } from "./i_email";

export default class NodeMailerService implements EmailService {
	async sendEmail(to: string, subject: string, text: string) {
		let testAccount = await nodemailer.createTestAccount();

		logger.info(testAccount);

		let transporter = nodemailer.createTransport({
			host: "smtp.ethereal.email",
			port: 587,
			secure: false, // true for 465, false for other ports
			auth: {
				user: testAccount.user, // generated ethereal user
				pass: testAccount.pass, // generated ethereal password
			},
		});

		let info = await transporter.sendMail({
			from: `"Ramen Cook 🍜" <${testAccount.user}>`, // sender address
			to, // list of receivers
			subject, // Subject line
			text, // plain text body
		});

		console.log("Message sent: %s", info.messageId);

		console.log("Preview URL: %s", nodemailer.getTestMessageUrl(info));
	}
}
