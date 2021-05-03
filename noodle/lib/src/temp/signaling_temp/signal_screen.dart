import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:noodle/src/core/config/rtc.dart';
import 'package:noodle/src/core/config/rtc_p2p.dart';
import 'package:noodle/src/temp/signaling_temp/signaling_server.dart';

class SignalScreen extends StatefulWidget {
  @override
  _SignalScreenState createState() => _SignalScreenState();
}

class _SignalScreenState extends State<SignalScreen> {
  MockSignalingServer _signalingServer = new MockSignalingServer();

  final sdpController = TextEditingController();

  @override
  void dispose() {
    rtcPeerToPeer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    rtcPeerToPeer.initRenderer();

    rtcPeerToPeer.createPC().then((pc) => rtcPeerToPeer.setPeerConnection(pc));

    super.initState();
  }

  SizedBox _videoRenderers() => SizedBox(
        height: 200,
        child: Row(
          children: [
            Flexible(
                child: Container(
              key: Key("local"),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.black),
              child: RTCVideoView(
                rtcPeerToPeer.localRenderer,
                mirror: true,
              ),
            )),
            Flexible(
                child: Container(
              key: Key("remote"),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.black),
              child: RTCVideoView(
                rtcPeerToPeer.remoteRenderer,
                mirror: true,
              ),
            ))
          ],
        ),
      );

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
            _videoRenderers(),
            RaisedButton(
              onPressed: _signalingServer.offer,
              child: Text(
                "offer",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
            ),
            RaisedButton(
              onPressed: _signalingServer.answer,
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
