import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/core/bloc/auth/auth_bloc.dart';
import 'package:noodle/src/core/bloc/auth/auth_event.dart';
import 'package:noodle/src/core/bloc/profile/profile_bloc.dart';
import 'package:noodle/src/core/bloc/profile/profile_event.dart';
import 'package:noodle/src/core/bloc/profile/profile_state.dart';
import 'package:noodle/src/core/models/authentication_status.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/resources/pages/setting/setting.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final User? user = state.user;
        if (user == null) return _FetchingScreen();
        return Container(
          child: Stack(
            children: [
              Container(
                  child: Container(
                child: Image.network(
                  user.avatarPath,
                ),
              )),
              _InfoSection(user: user),
              Container(
                height: 60,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.cog,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingScreen()));
                        })
                  ],
                ),
              )
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
            _LogoutButton(),
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
        user.firstName + ' ' + user.lastName,
        style: Theme.of(context).textTheme.headline1,
      ),
      subtitle: Text(
        '@' + user.username,
        style: Theme.of(context).textTheme.headline2,
      ),
      trailing: ElevatedButton(
        onPressed: () {},
        child: Text("Connect", style: TextStyle(fontWeight: FontWeight.bold)),
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

class _LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Provider.of<AuthenticationBloc>(context, listen: false).add(
            AuthenticationStatusChanged(AuthenticationStatus.LOGOUT_REQUESTED));
      },
      child: Text("Log out", style: TextStyle(fontWeight: FontWeight.bold)),
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
