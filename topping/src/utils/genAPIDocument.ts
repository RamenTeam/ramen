import * as swaggerDocument from "../../swagger.json";
import * as swaggerDTODocument from "../../swagger-dto.json";
import * as swaggerUi from "swagger-ui-express";

export const genAPIDocument = (app: any) => {
	const REST_ENDPOINT: string = "/api";

	Object.assign(swaggerDocument.components.schemas, swaggerDTODocument);

	app.use(REST_ENDPOINT, swaggerUi.serve);
	app.get(REST_ENDPOINT, swaggerUi.setup(swaggerDocument));
};
