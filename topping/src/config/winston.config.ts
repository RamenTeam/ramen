import { createLogger, format, transports, LoggerOptions } from "winston";

const logOptions: LoggerOptions = {
	level: "info",
	transports: [new transports.Console()],
	format: format.combine(
		format.json(),
		format.timestamp({
			format: "DD/MM | HH:mm",
		}),
		format.colorize(),
		format.simple(),
		format.prettyPrint({
			colorize: true,
		})
	),
};

export const logger = createLogger(logOptions);

logger.exitOnError = false;
