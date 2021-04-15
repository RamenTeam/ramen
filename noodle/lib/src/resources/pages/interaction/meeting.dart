import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/resources/pages/setting/setting.dart';
import 'package:noodle/src/resources/pages/interaction/local_widget/video_player.dart';

class MeetingScreen extends StatefulWidget {
  MeetingScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MeetingScreen());
  }

  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    Widget buildMeetingUserInfo() {
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
          VideoApp(),
          buildMeetingUserInfo(),
          Align(
            alignment: Alignment(1, 1),
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
