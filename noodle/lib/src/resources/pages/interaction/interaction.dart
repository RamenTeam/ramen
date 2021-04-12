import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/resources/pages/setting/setting.dart';

class InteractionScreen extends StatefulWidget {
  InteractionScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => InteractionScreen());
  }

  @override
  _InteractionScreenState createState() => _InteractionScreenState();
}

class _InteractionScreenState extends State<InteractionScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    Widget buildInteractionUserInfo() {
      return Container(
          margin: EdgeInsets.only(top: screenSize.height / 1.2),
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
          child: Padding(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text("user name",
                        style: Theme.of(context).textTheme.headline3),
                  ),
                ],
              )));
    }

    return Scaffold(
      body: Stack(
        children: [
          //video call
          Container(),
          buildInteractionUserInfo(),
          Align(
            alignment: Alignment(.5, .8),
            child: Column(
              children: [
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.exclamationCircle,
                        color: Colors.red),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingScreen()));
                    }),
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.heart,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingScreen()));
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
