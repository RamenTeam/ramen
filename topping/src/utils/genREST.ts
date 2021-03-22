import { GraphQLSchema } from "graphql";
import sofa, { OpenAPI } from "sofa-api";
import * as swaggerUi from "swagger-ui-express";
import * as swaggerDocument from "../../swagger.json";

export const genREST_API = (schema: GraphQLSchema, app: any) => {
	const REST_ENDPOINT: string = "/api";

	const openApi = OpenAPI({
		schema,
		info: {
			title: "Ramen RESTful API",
			version: "3.0.0",
		},
	});

	app.use(
		REST_ENDPOINT,
		sofa({
			schema,
			onRoute(info) {
				openApi.addRoute(info, {
					basePath: REST_ENDPOINT,
				});
			},
		} as any)
	);

	app.use(REST_ENDPOINT, swaggerUi.serve, swaggerUi.setup(swaggerDocument));

	// openApi.save("./swagger.json");
};
