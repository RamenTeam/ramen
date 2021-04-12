import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:noodle/src/resources/pages/interaction/interaction.dart';
import 'package:noodle/src/resources/pages/navigation/home_navigation.dart';

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

  Container icon() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Image.asset(
        "assets/images/logo.png",
      ),
    );
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
          color: Colors.black,
          size: 20,
        ),
      ),
    );
  }

  Container button() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                isFinding ? Colors.red : Colors.yellow)),
        child: Text(
          isFinding ? "Cancel" : "Find a partner",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        onPressed: findPartner,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon(),
          tooltipText(),
          spinKitThreeBounce(),
          button(),
        ],
      ),
    );
  }
}
