import { GraphQLSchema } from "graphql";
import sofa, { OpenAPI } from "sofa-api";

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

	openApi.save("./swagger.json");
};
