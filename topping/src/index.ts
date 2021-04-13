import { startServer } from "./startServer";
import { Container } from "typedi";
import * as typeorm from "typeorm";

console.log("Server boots up!");

typeorm.useContainer(Container);

startServer().catch((err) => console.log(err));
