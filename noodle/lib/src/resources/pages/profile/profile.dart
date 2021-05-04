import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:noodle/src/resources/pages/auth/bloc/auth_bloc.dart';
import 'package:noodle/src/resources/pages/connection_list/connection_list_screen.dart';
import 'package:noodle/src/resources/pages/profile/bloc/user_cubit.dart';
import 'package:noodle/src/resources/pages/update_profile/bloc/update_profile_cubit.dart';
import 'package:noodle/src/resources/pages/update_profile/update_profile_screen.dart';
import 'package:noodle/src/resources/shared/home_app_bar.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, User>(
      builder: (context, state) {
        final User? user = state;
        if (user == null) return _FetchingScreen();
        return Scaffold(
          appBar: HomeAppBar(
            title: "Profile",
            userCubit: Provider.of<UserCubit>(context, listen: false),
            authBloc: Provider.of<AuthenticationBloc>(context, listen: false),
          ),
          body: Stack(
            children: [
              Container(
                  child: Image.network(
                user.avatarPath,
              )),
              _InfoSection(user: user),
            ],
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

class _InfoSection extends StatelessWidget {
  _InfoSection({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: screenSize.height / 2.2),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35))),
      child: Padding(
        padding: EdgeInsets.only(right: 10, left: 10),
        child: ListView(
          children: [
            SizedBox(height: 20),
            _ProfileInfoHeader(user: user),
            _BioSection(bio: user.bio),
          ],
        ),
      ),
    );
  }
}

class _ProfileInfoHeader extends StatelessWidget {
  _ProfileInfoHeader({
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FlutterLogo(),
      title: Text(
        user.name,
        style: Theme.of(context).textTheme.headline1,
      ),
      subtitle: Text(
        '@' + user.username,
        style: Theme.of(context).textTheme.headline2,
      ),
      trailing: Wrap(
        spacing: 5,
        children: [
          _ViewConnectionsButton(users: user.connections),
          _UpdateProfileButton(
            user: user,
          ),
        ],
      ),
    );
  }
}

class _BioSection extends StatelessWidget {
  _BioSection({this.bio = ""});

  final String bio;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text("Bio", style: Theme.of(context).textTheme.headline3)),
        subtitle: Text(bio, style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }
}

class _ViewConnectionsButton extends StatelessWidget {
  _ViewConnectionsButton({required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print("Connect");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ConnectionListScreen(
            // Mock
            // users: [
            //   User.mock,
            //   User.mock1,
            //   User.mock2,
            // ],
            // Reality
            users: users,
            userRepository: Provider.of<UserRepository>(context, listen: false),
          );
        }));
      },
      child: Wrap(
        spacing: 5,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(Icons.people_alt_rounded),
          Text(users.length.toString()),
        ],
      ),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0.0),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor:
            MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}

class _UpdateProfileButton extends StatelessWidget {
  _UpdateProfileButton({
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print("Update");
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext c) {
          return UpdateProfileScreen(
            userCubit: Provider.of<UserCubit>(context, listen: false),
            updateProfileCubit: UpdateProfileCubit(
              userRepository:
                  Provider.of<UserRepository>(context, listen: false),
            ),
          );
        }));
      },
      child: Icon(Icons.edit),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0.0),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor:
            MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
