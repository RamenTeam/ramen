import 'package:flutter/material.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/pages/profile/other_profile.dart';
import 'package:noodle/src/resources/shared/backable_app_bar.dart';

class ConnectionListScreen extends StatelessWidget {
  ConnectionListScreen({required this.users, required this.userRepository});

  final List<User> users;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackableAppBar(title: "Your connections"),
      backgroundColor: Theme.of(context).accentColor,
      body: ListView(
        children: [
          for (User user in users)
            _Card(
              user: user,
              userRepository: userRepository,
            ),
          // _Card(user:User.mock, userRepository: userRepository,),
          // _Card(user:User.mock1, userRepository: userRepository,),
          // _Card(user:User.mock2, userRepository: userRepository,),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  _Card({required this.user, required this.userRepository});

  final User user;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext c) {
          return OtherProfileScreen(
            user: user,
            userRepository: userRepository,
          );
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
