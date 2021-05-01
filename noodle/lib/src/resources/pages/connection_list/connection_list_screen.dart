import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/resources/pages/profile/bloc/user_cubit.dart';
import 'package:noodle/src/resources/pages/update_profile/bloc/update_profile_cubit.dart';
import 'package:noodle/src/resources/pages/update_profile/bloc/update_profile_state.dart';
import 'package:noodle/src/resources/shared/backable_app_bar.dart';
import 'package:noodle/src/resources/shared/form_input.dart';
import 'package:noodle/src/resources/shared/submit_button.dart';

class ConnectionListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackableAppBar(title: "Your connections"),
      backgroundColor: Theme.of(context).accentColor,
      body: ListView(
        children: [
          _Card(user: User.mock()),
          _Card(user: User.mock()),
          _Card(user: User.mock()),
          _Card(user: User.mock()),
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
      onTap: () {},
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
