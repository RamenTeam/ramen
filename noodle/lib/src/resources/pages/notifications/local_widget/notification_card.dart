import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
class NotificationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xFF000000),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
              ),
              title: Text('this is the user name',
                  style: TextStyle(fontSize: 20, color: Color(0xFFFDAD00))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(onPressed: () {}, child: Text('Accept')),
                const SizedBox(width: 8),
                TextButton(onPressed: () {}, child: Text('Deny')),
                const SizedBox(width: 8),
              ],
            )
          ],
        ));
  }
}
