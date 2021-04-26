import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: import_of_legacy_library_into_null_safe
class ViewNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
              color: Color(0xff000000),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Image(
                      image: NetworkImage(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                      height: 12,
                      width: 12,
                    ),
                    title: Text('this is the user name'),
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
              ))
        ],
      ),
    );
  }
}
