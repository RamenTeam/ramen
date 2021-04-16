import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noodle/src/resources/pages/home/local_build/build_banner.dart';
import 'package:noodle/src/resources/shared/app_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFinding = false;
  void findPartner() {
    setState(() {
      isFinding = !isFinding;
    });
  }

  Container tooltipText() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Visibility(
        maintainState: true,
        maintainAnimation: true,
        maintainSize: true,
        visible: isFinding,
        child: Text(
          "Finding a partner for you",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Container spinKitThreeBounce() {
    return Container(
      child: Visibility(
        maintainState: true,
        maintainAnimation: true,
        maintainSize: true,
        visible: isFinding,
        child: SpinKitThreeBounce(
          color: Theme.of(context).textTheme.headline1?.color,
          size: 20,
        ),
      ),
    );
  }

  Widget button() {
    return ClipOval(
      child: Material(
        color: isFinding
            ? Colors.red
            : Theme.of(context).primaryColor, // button color
        child: InkWell(
          splashColor: Colors.red, // inkwell color
          child: SizedBox(
              width: 60,
              height: 60,
              child: Center(
                  child: isFinding
                      ? spinKitThreeBounce()
                      : FaIcon(
                          FontAwesomeIcons.play,
                          color: Theme.of(context).textTheme.headline1?.color,
                          size: 18,
                        ))),
          onTap: findPartner,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SharedAppBar(
          title: 'Ramen',
        ),
        backgroundColor: Theme.of(context).accentColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildBanner(context, isFinding),
              SizedBox(height: 20),
              Text(
                isFinding ? "Finding a partner..." : "Welcome to Ramen!",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.headline1?.color),
              ),
              SizedBox(height: 5),
              Text(
                  isFinding
                      ? "Click a button to cancel"
                      : "Only 30 seconds for a conversation.",
                  style: TextStyle(
                    fontSize: 17,
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  )),
              // tooltipText(),
              SizedBox(height: 30),
              button(),
            ],
          ),
        ));
  }
}
