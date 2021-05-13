import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:noodle/src/core/config/graphql_client.dart';
import 'package:noodle/src/core/models/connect_notification.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/schema/queries/get_my_notifications.query.dart';
import 'package:noodle/src/core/schema/query_option.dart';
import 'package:noodle/src/core/schema/subscription_option.dart';
import 'package:noodle/src/core/schema/subscriptions/new_notification_added.subscription.dart';

class NotificationRepository {
  Future<List<ConnectionNotification>> getMyNotifications() async {
    GraphQLClient client = getGraphQLClient();

    final QueryResult res =
        await client.query(getQueryOptions(schema: getMyNotificationsQuery));

    if (res.hasException) {
      print(res.exception.toString());
      return [];
    }

    List<dynamic> notificationsJson = res.data['getMyNotifications'];

    List<ConnectionNotification> notifications = notificationsJson.map((n) {
      dynamic fromUserJson = n['from'];
      User? fromUser = User(
          id: fromUserJson['id'],
          name: fromUserJson['name'],
          username: fromUserJson['username'],
          avatarPath: fromUserJson['avatarPath']);
      return ConnectionNotification(
        id: n['id'],
        from: fromUser,
        createdAt: n['createdAt'],
        label: n['label'],
      );
    }).toList();

    return notifications;
  }

  Stream<QueryResult> getNewNotificationStream() {
    GraphQLClient client = getGraphQLWebsocketClient();
    Stream<QueryResult> stream = client.subscribe(
        getSubscriptionOptions(schema: newNotificationAddedSubscription));
    return stream;
  }
}
