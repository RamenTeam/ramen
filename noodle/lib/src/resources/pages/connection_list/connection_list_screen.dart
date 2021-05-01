import 'package:flutter/material.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/resources/pages/profile/other_profile.dart';
import 'package:noodle/src/resources/shared/backable_app_bar.dart';

class ConnectionListScreen extends StatelessWidget {
  ConnectionListScreen({required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackableAppBar(title: "Your connections"),
      backgroundColor: Theme.of(context).accentColor,
      body: ListView(
        children: [
          for (User user in users) _Card(user: user),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  _Card({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext c) {
          return OtherProfileScreen(user: user);
        }));
      },
      //TODO: when the user tap
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: Image.network(user.avatarPath).image,
      ),
      title: Text(
        user.firstName + " " + user.lastName,
        style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
      ),
      subtitle: Text(
        '@' + user.username,
        style: TextStyle(
            fontSize: 16, color: Theme.of(context).textTheme.headline1!.color),
      ),
    );
  }
}
