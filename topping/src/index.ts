import { startServer } from "./startServer";
import { Container } from "typedi";
import * as typeorm from "typeorm";
import * as LogRocket from "logrocket";

console.log("Server boots up!");

LogRocket.init("xmvgpi/ramen");
typeorm.useContainer(Container);

startServer().catch((err) => console.log(err));
