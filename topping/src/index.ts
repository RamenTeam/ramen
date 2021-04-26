import { startServer } from "./startServer";
import { Container } from "typedi";
import * as typeorm from "typeorm";
import { sentryInit } from "./helper/sentry";
import * as Sentry from "@sentry/node";

console.log("Server boots up!");

sentryInit();

const transaction = Sentry.startTransaction({
	op: "Ramen",
	name: "My First Test Ramen Transaction",
});

typeorm.useContainer(Container);

const main = async () => {
	try {
		await startServer();
	} catch (err) {
		console.log(err);
		Sentry.captureException(err);
	} finally {
		transaction.finish();
	}
};
setTimeout(main, 99);
