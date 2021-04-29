import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
class NotificationCard extends StatelessWidget {
  String _timeStamp = "1m";
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap:
            () {}, //TODO: when the user tap, a function will call to mark notification as read
        leading: CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
        ),
        title: Text(
          'this is the user name',
          style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).textTheme.headline1!.color),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
                child: Text(
                  'Accept',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color),
                )), //TODO: when click, call a function to add a user to the current user friend list, then delete the friend request
            const SizedBox(width: 8),

            TextButton(
                onPressed: () {},
                child: Text(
                  'Deny',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color),
                )), //TODO: when click, delete the friend request
            const SizedBox(width: 8),
          ],
        ),
        trailing: Text(
          _timeStamp,
          style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
        ));
  }
}
