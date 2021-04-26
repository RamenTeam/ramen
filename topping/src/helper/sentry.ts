import * as Sentry from "@sentry/node";

const dsn =
	"https://bcb8877717634d00933a4a61e6b5242b@o580677.ingest.sentry.io/5735634";

export const sentryInit = () =>
	Sentry.init({
		dsn,
		tracesSampleRate: 1.0,
	});
