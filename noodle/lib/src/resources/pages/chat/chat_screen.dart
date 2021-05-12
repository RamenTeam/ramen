import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:noodle/src/resources/pages/connection_list/connection_list_screen.dart';
import 'package:noodle/src/resources/pages/home_navigation/bloc/tab_navigation_cubit.dart';
import 'package:noodle/src/resources/pages/profile/bloc/user_cubit.dart';
import 'package:noodle/src/resources/pages/update_profile/bloc/update_profile_cubit.dart';
import 'package:noodle/src/resources/pages/update_profile/update_profile_screen.dart';
import 'package:noodle/src/resources/shared/home_app_bar.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, User>(
      builder: (context, state) {
        final User? user = state;
        if (user == null) return _FetchingScreen();
        return Scaffold(
          appBar: HomeAppBar(
            title: "Chat",
            userCubit: Provider.of<UserCubit>(context, listen: false),
            userRepository: Provider.of<UserRepository>(context, listen: false),
          ),
          backgroundColor: Theme.of(context).accentColor,
          body: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "CONNECTIONS",
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 10),
                _ConnectionList(),
                SizedBox(height: 10),
                Text(
                  "MESSAGES",
                  style: Theme.of(context).textTheme.headline2,
                ),
                _MessagePreviewList(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FetchingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitRing(
      color: Theme.of(context).primaryColor,
      size: 50.0,
    ));
  }
}

class _ConnectionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserCubit>(context, listen: false).getUser();
    if (user == null) return ListView();
    List<User> connections = user.connections;
    return SizedBox(
      height: 125,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (var user in connections) _ConnectionItem(user: user),
        ],
      ),
    );
  }
}

class _ConnectionItem extends StatelessWidget {
  _ConnectionItem({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(user.avatarPath),
              radius: 40,
            ),
          ),
          Text(
            user.username,
            style: Theme.of(context).textTheme.headline2,
          ),
        ],
      ),
    );
  }
}

class _MessagePreviewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserCubit>(context, listen: false).getUser();
    if (user == null) return ListView();
    List<User> connections = user.connections;
    return Flexible(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          for (var user in connections)
            _MessagePreview(
              user: user,
              latestMessage: "Hi!",
            ),
        ],
      ),
    );
  }
}

class _MessagePreview extends StatelessWidget {
  _MessagePreview({required this.user, required this.latestMessage});

  final User user;
  final String latestMessage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListTile(
        onTap: () {
          print("Open inbox with " + user.username);
        },
        //TODO: when the user tap
        leading: CircleAvatar(
          radius: 20,
          backgroundImage: Image.network(user.avatarPath).image,
        ),
        title: Text(
          user.name,
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Text(
          latestMessage,
          style: Theme.of(context).textTheme.headline2,
        ),
        trailing: Text(
          '21:46 5/12/2021',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}

class _EmptyInbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('No history of conversations right now',
              style: Theme.of(context).textTheme.headline2),
          SizedBox(
            height: 10,
          ),
          Text("Let's have a bowl of Ramen",
              style: Theme.of(context).textTheme.bodyText1),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
