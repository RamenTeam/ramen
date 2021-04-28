import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:noodle/src/temp/rtc_temp/rtc_sandbox.dart';

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  RTCSandBox _rtcSandBox = new RTCSandBox();

  @override
  void dispose() {
    _rtcSandBox.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _rtcSandBox.initRenderer();
    _rtcSandBox.getUserMedia();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Call Screen"),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey),
        child: new RTCVideoView(
          _rtcSandBox.localRenderer,
          objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
          filterQuality: FilterQuality.medium,
        ),
      ),
    );
  }
}
