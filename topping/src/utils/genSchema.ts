import { GraphQLSchema } from "graphql";
import { buildSchema } from "type-graphql";
import { Container } from "typedi";
// import { redisPubSub } from "../helper/redis";
import { customAuthChecker } from "./authChecker";
import { ResolveTime } from "../modules/middleware";
import * as User from "../modules/resolvers/user";
import * as Notification from "../modules/resolvers/notification";
import * as Chat from "../modules/resolvers/chat";
import * as Conversation from "../modules/resolvers/conversation";

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
			User.AcceptConnectionRequestResolver,
			User.RejectConnectionRequestResolver,
			User.GetConnectionRequestResolver,
			Chat.NewMessageSendedResolver,
			Chat.SendMessageResolver,
			Conversation.GetConversation,
			Conversation.GetConversations,
			Conversation.CreateDirectConversation,
			Notification.GetNotificationsResolver,
			Notification.GetMyNotificationsResolver,
			Notification.NewNotificationAddedResolver,
		],
		container: Container,
		authChecker: customAuthChecker,
		globalMiddlewares: [ResolveTime],
	});

	return schema;
};
