import { startServer } from "./startServer";
import { Container } from "typedi";
import * as typeorm from "typeorm";

typeorm.useContainer(Container);

startServer().catch((err) => console.log(err));
