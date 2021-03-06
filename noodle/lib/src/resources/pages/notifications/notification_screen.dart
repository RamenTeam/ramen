import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/models/connect_notification.dart';
import 'package:noodle/src/core/models/ramen_api_response.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/repositories/connection_repository.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/pages/notifications/bloc/notification_cubit.dart';
import 'package:noodle/src/resources/pages/profile/bloc/user_cubit.dart';
import 'package:noodle/src/resources/shared/home_app_bar.dart';
import 'package:noodle/src/utils/time.dart';
import 'package:provider/provider.dart';

import 'bloc/notification_state.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: 'Notifications',
        userCubit: Provider.of<UserCubit>(context, listen: false),
        userRepository: Provider.of<UserRepository>(context, listen: false),
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: SafeArea(
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            return ListView(
              children: [
                // Items
                for (var notification in state.notifications)
                  _Card(notification: notification),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  _Card({required this.notification});

  final ConnectionNotification notification;

  @override
  Widget build(BuildContext context) {
    User user = notification.from;

    Future<void> acceptConnectionRequest() async {
      ErrorMessage? err =
          await Provider.of<ConnectionRepository>(context, listen: false)
              .acceptConnectionRequest(id: notification.id);
      String message = "You are now connected with " + user.name + "!";
      if (err != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
      await Provider.of<NotificationCubit>(context, listen: false)
          .fetchNotifications();
      // Re-fetch user data after connection accepted
      if (err == null) {
        await Provider.of<UserCubit>(context, listen: false).fetchUser();
      }
    }

    Future<void> rejectConnectionRequest() async {
      ErrorMessage? err =
          await Provider.of<ConnectionRepository>(context, listen: false)
              .rejectConnectionRequest(id: notification.id);
      String message = "Connection request with " + user.name + " declined!";
      if (err != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
      await Provider.of<NotificationCubit>(context, listen: false)
          .fetchNotifications();
    }

    return ListTile(
        onTap: () {},
        //TODO: when the user tap, a function will call to mark notification as read
        leading: CircleAvatar(
            radius: 30, backgroundImage: Image.network(user.avatarPath).image),
        title: Text(
          user.username,
          style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  acceptConnectionRequest();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
                child: Text(
                  'Accept',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color),
                )),
            //TODO: when click, call a function to add a user to the current user friend list, then delete the friend request
            const SizedBox(width: 8),

            TextButton(
                onPressed: () {
                  rejectConnectionRequest();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).secondaryHeaderColor)),
                child: Text(
                  'Deny',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color),
                )),
            //TODO: when click, delete the friend request
            const SizedBox(width: 8),
          ],
        ),
        trailing: Text(
          formatTime(notification.createdAt),
          style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
        ));
  }
}
