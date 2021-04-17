import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe

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

    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: SafeArea(
          child: Stack(children: [
            Container(color: Colors.green),
            Column(
              children: [
                // Top
                Container(
                    height: 100,
                    color: Colors.yellow,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.blue),
                            ),
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
                          ],
                        ),
                        Spacer(),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue),
                        ),
                      ],
                    )),
                // Middle
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 140,
                          height: 180,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red),
                          margin: EdgeInsets.only(left: 20, bottom: 20),
                        )
                      ],
                    ),
                    Spacer(),
                    Container(
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
                    )
                  ],
                ))
              ],
            )
          ]),
        ));
  }
}
