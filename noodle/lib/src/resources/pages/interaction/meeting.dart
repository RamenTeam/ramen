import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:noodle/src/resources/pages/interaction/local_widget/meeting_user_pages.dart';

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
    final PageController controller = PageController(initialPage: 0);

    return Scaffold(
        body: SafeArea(
            child: PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: [
        buildPages(this.context, screenSize),
        buildPages(this.context, screenSize),
      ],
    )));
  }
}
