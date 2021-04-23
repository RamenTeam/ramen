import { GraphQLSchema } from "graphql";
import { buildSchema } from "type-graphql";
import { Container } from "typedi";
// import { redisPubSub } from "../helper/redis";
import { customAuthChecker } from "./authChecker";
import { ResolveTime } from "../modules/middleware";
import * as User from "../modules/resolvers/user";
import * as Notification from "../modules/resolvers/notification";

export const genSchema = async (): Promise<GraphQLSchema> => {
	// const modulePath = "../modules/**/*.resolver.{ts,js}";
	// path.join(__dirname + modulePath)
	const schema = await buildSchema({
		resolvers: [
			User.GetUserResolver,
			User.GetUsersResolver,
			User.LoginResolver,
			User.LogoutResolver,
			User.MeResolver,
			User.RegisterResolver,
			User.ForgotPasswordResolver,
			User.ConnectResolver,
			User.UpdateProfileResolver,
			Notification.GetNotificationsResolver,
			Notification.GetMyNotificationsResolver,
			Notification.NewNotificationAddedResolver,
		],
		container: Container,
		// pubSub: redisPubSub,
		authChecker: customAuthChecker,
		globalMiddlewares: [ResolveTime],
	});

	return schema;
};
