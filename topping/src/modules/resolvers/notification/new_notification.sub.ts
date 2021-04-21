// import { Args, Root, Subscription } from "type-graphql";

// class NotificationResolver {
//     // ...
//     @Subscription({
//       topics: "NOTIFICATIONS",
//       filter: ({ payload, args }) => args.priorities.includes(payload.priority),
//     })
//     newNotification(
//       //@Root() notificationPayload: NotificationPayload,
//       //@Args() args: NewNotificationsArgs,
//     ): Notification {
//       return {
//         ...notificationPayload,
//         date: new Date(),
//       };
//     }
//   }
