import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noodle/src/core/models/ramen_api_response.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/shared/backable_app_bar.dart';
import 'package:provider/provider.dart';

class OtherProfileScreen extends StatelessWidget {
  final User user;
  final UserRepository userRepository;

  const OtherProfileScreen({required this.user, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackableAppBar(
        title: '@' + user.username,
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: Stack(
        children: [
          Container(
              child: Image.network(
            user.avatarPath,
          )),
          Provider<UserRepository>(
            create: (_) => userRepository,
            child: _InfoSection(user: user),
          )
        ],
      ),
    );
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
          _ConnectButton(
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

class _ConnectButton extends StatelessWidget {
  _ConnectButton({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    void sendConnectRequest() async {
      print("Sending connect request to " + user.username);
      ErrorMessage? err =
          await Provider.of<UserRepository>(context, listen: false)
              .sendConnectRequest(id: user.id);
      String message = "Send connect request successfully!";
      if (err != null) message = err.message;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }

    return ElevatedButton(
      onPressed: () {
        sendConnectRequest();
      },
      child: Icon(Icons.person_add),
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
