import { startServer } from "./startServer";
import { Container } from "typedi";
import * as typeorm from "typeorm";
import { logger } from "./config/winston.config";

console.log("Server boots up!");

typeorm.useContainer(Container);

startServer().catch((err) => logger.error(err));
