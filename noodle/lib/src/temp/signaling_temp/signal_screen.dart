import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noodle/src/temp/signaling_temp/signaling_server.dart';

class SignalScreen extends StatefulWidget {
  @override
  _SignalScreenState createState() => _SignalScreenState();
}

class _SignalScreenState extends State<SignalScreen> {
  MockSignalingServer _signalingServer = new MockSignalingServer();

  _offer() {}

  _answer() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Signaling Server Sandbox"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: _offer,
              child: Text(
                "offer",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
            ),
            RaisedButton(
              onPressed: _answer,
              child: Text(
                "answer",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            ),
            RaisedButton(
              onPressed: _signalingServer.connect,
              child: Text(
                "connect",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.green,
            ),
            RaisedButton(
              onPressed: _signalingServer.disconnect,
              child: Text(
                "disconnect",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.grey,
            ),
          ],
        )));
  }
}
