import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  bool isFinding = false;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void findPartner() {
    setState(() {
      widget.isFinding = !widget.isFinding;
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
        visible: widget.isFinding,
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
        visible: widget.isFinding,
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
                widget.isFinding ? Colors.red : Colors.yellow)),
        child: Text(
          widget.isFinding ? "Cancel" : "Find a partner",
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
