declare namespace NodeJS {
	interface ProcessEnv {
		SESSION_SECRET: string;
		CLIENT_PORT: string;
		POSTGRES_URL: string;
		POSTGRES_USER: string;
		POSTGRES_PASSWORD: string;
		MONGODB_URI: string;
		SERVER_URI: string;
		SERVER_ENDPOINT: string;
		TEST_HOST: string;
		PROD_SERVER_HOST: string;
	}
}
