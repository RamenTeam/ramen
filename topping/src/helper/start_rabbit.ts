import amqp, { Connection } from "amqplib";

const RABBIT_URI = process.env.RABBITMQ_URL || "amqp://localhost";
const QUEUE_ID = process.env.QUEUE_ID || "";
const rabbit = "🐇";

const retryInterval = 5000;

const reconnectRabbit = (handler) =>
	setTimeout(async () => await startRabbit(handler), retryInterval);

export const startRabbit = async (handler) => {
	console.log(`${rabbit} - Trying to connect to: `, RABBIT_URI);
	let conn: Connection;
	try {
		conn = await amqp.connect(RABBIT_URI);
	} catch (error) {
		console.log(`${rabbit} - Unable to connect to RabbitMQ: `, error);
		reconnectRabbit(handler);
		return;
	}
	conn.on("close", async (err: Error) => {
		console.error(`${rabbit} - Rabbit connection closed with error: `, err);
		reconnectRabbit(handler);
		return;
	});

	const id = QUEUE_ID;
	console.log(`${rabbit} - Rabbit connected ` + id);

	const ch = await conn.createChannel();

	const helloWorldQueue = "hello_world_queue" + id;

	await Promise.all([ch.assertQueue(helloWorldQueue)]);

	const msg = "hello world";

	ch.sendToQueue(helloWorldQueue, Buffer.from(msg));

	console.log(" [x] Sent %s", msg);
};
