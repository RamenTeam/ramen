import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gql_exec/gql_exec.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:noodle/src/resources/pages/notifications/local_widget/notification_card.dart';

class ViewNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
            NotificationCard(),
          ],
        ),
      ),
    );
  }
}
