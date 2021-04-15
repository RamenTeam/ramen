import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
          color: Theme.of(context).primaryColor,
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
              width: 56,
              height: 56,
              child: Icon(Icons.menu, color: Theme.of(context).accentColor)),
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
              buildBanner(),
              tooltipText(),
              spinKitThreeBounce(),
              button(),
            ],
          ),
        ));
  }
}
