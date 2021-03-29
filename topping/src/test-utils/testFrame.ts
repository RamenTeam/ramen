import { Connection } from "typeorm";
import { genORMConnection } from "../config/orm.config";

let conn: Connection | null = null;
export const testFrame = (cb: Function) => {
	beforeAll(async () => {
		conn = await genORMConnection(false);
	});

	cb();

	afterAll(async () => {
		await conn?.close();
	});
};
