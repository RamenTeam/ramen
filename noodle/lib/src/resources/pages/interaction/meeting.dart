import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noodle/src/core/models/user.dart';
// ignore: import_of_legacy_library_into_null_safe

class MeetingScreen extends StatefulWidget {
  MeetingScreen({Key? key, required this.peer}) : super(key: key);

  final User? peer;

  static Route route({required User peer}) {
    return MaterialPageRoute<void>(
        builder: (_) => MeetingScreen(
              peer: peer,
            ));
  }

  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = PageController(initialPage: 0);

    final screenSize = MediaQuery.of(context).size;

    final pageView = PageView(
      controller: controller,
      scrollDirection: Axis.vertical,
      children: [
        Container(
            color: Colors.green,
            child: FittedBox(
              child: Image.network(
                "https://media.giphy.com/media/xT9IgoJNoU4ZSTD0Gs/giphy.gif",
              ),
              fit: BoxFit.cover,
            )),
        Container(
            color: Colors.cyanAccent,
            child: FittedBox(
              child: Image.network(
                "https://media.giphy.com/media/3o7aDc5eHYx1vCXjKE/giphy.gif",
              ),
              fit: BoxFit.cover,
            )),
        Container(
            color: Colors.cyanAccent,
            child: FittedBox(
              child: Image.network(
                "https://media.giphy.com/media/1otEs4D4BJgQ0/giphy.gif",
              ),
              fit: BoxFit.cover,
            )),
      ],
    );

    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: SafeArea(
          child: Stack(children: [
            pageView,
            Column(
              children: [
                // Top
                _TopSection(),
                // Middle
                _MiddleSection()
              ],
            )
          ]),
        ));
  }
}

class _TopSection extends StatelessWidget {
  List<Widget> buildInfo() {
    return [
      // Avatar
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      ),
      // Name & Username
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: 200,
            decoration: BoxDecoration(color: Colors.blue),
          ),
          Container(
            height: 30,
            width: 200,
            decoration: BoxDecoration(color: Colors.blue),
          )
        ],
      )
    ];
  }

  Widget buildBackButton() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        color: Colors.yellow,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Row(children: buildInfo()), Spacer(), buildBackButton()],
        ));
  }
}

class _MiddleSection extends StatelessWidget {
  Widget buildInteractionButtons() {
    return Container(
      width: 90,
      color: Colors.blue,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
              3,
              (index) => Container(
                  width: 60,
                  height: 60,
                  color: Colors.red,
                  margin: EdgeInsets.only(top: 20)))),
    );
  }

  Widget buildCamera() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 140,
          height: 180,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: FittedBox(
              child: Image.network(
                  "https://media.giphy.com/media/nc1Xx0poE6PvNVSEVG/giphy.gif"),
              fit: BoxFit.cover,
            ),
          ),
          margin: EdgeInsets.only(left: 20, bottom: 20),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [buildCamera(), Spacer(), buildInteractionButtons()],
    ));
  }
}
