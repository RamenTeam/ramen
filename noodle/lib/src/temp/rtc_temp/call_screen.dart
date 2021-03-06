// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:logger/logger.dart';
// import 'package:noodle/src/core/config/rtc.dart';
// import 'package:noodle/src/temp/rtc_temp/rtc_sandbox.dart';
//
// class CallScreen extends StatefulWidget {
//   @override
//   _CallScreenState createState() => _CallScreenState();
// }
//
// class _CallScreenState extends State<CallScreen> {
//   // RTCSandBox _rtcSandBox = new RTCSandBox();
//
//   final sdpController = TextEditingController();
//
//   @override
//   void dispose() {
//     rtcPeerToPeer.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     rtcPeerToPeer.initRenderer();
//
//     rtcPeerToPeer.createPC().then((pc) => rtcPeerToPeer.setPeerConnection(pc));
//
//     super.initState();
//   }
//
//   SizedBox _videoRenderers() => SizedBox(
//         height: 200,
//         child: Row(
//           children: [
//             Flexible(
//                 child: Container(
//               key: Key("local"),
//               margin: EdgeInsets.all(5),
//               decoration: BoxDecoration(color: Colors.black),
//               child: RTCVideoView(
//                 rtcPeerToPeer.localRenderer,
//                 mirror: true,
//               ),
//             )),
//             Flexible(
//                 child: Container(
//               key: Key("remote"),
//               margin: EdgeInsets.all(5),
//               decoration: BoxDecoration(color: Colors.black),
//               child: RTCVideoView(
//                 rtcPeerToPeer.remoteRenderer,
//                 mirror: true,
//               ),
//             ))
//           ],
//         ),
//       );
//
//   Row _offerAndAnswerButtons() => Row(
//         children: [
//           RaisedButton(
//             onPressed: rtcPeerToPeer.offer,
//             child: Text("Offer"),
//             color: Colors.amber,
//           ),
//           RaisedButton(
//             onPressed: rtcPeerToPeer.answer,
//             child: Text("Answer"),
//             color: Colors.blue,
//           ),
//         ],
//       );
//
//   Padding _sdpCandidateTF() => Padding(
//         padding: EdgeInsets.all(15),
//         child: TextField(
//           controller: sdpController,
//           keyboardType: TextInputType.multiline,
//           maxLines: 5,
//           maxLength: TextField.noMaxLength,
//         ),
//       );
//
//   Row _sdpCandidateButtons() => Row(
//         children: [
//           RaisedButton(
//               onPressed: () =>
//                   rtcPeerToPeer.setRemoteDescription(sdpController.text, null),
//               child: Text("SetRemoteDesc."),
//               color: Colors.amber),
//           RaisedButton(
//               onPressed: () => rtcPeerToPeer.setCandidate(sdpController.text),
//               child: Text("Set Candidate."),
//               color: Colors.blue),
//         ],
//       );
//
//   RaisedButton _disposeButton() => RaisedButton(
//       onPressed: dispose, child: Text("Dispose"), color: Colors.red);
//
//   RaisedButton _reconnectButton() => RaisedButton(
//       onPressed: initState, child: Text("Reconnect"), color: Colors.green);
//
//   RaisedButton _clearSdpControllerButton() => RaisedButton(
//       onPressed: () {
//         sdpController.clear();
//       },
//       child: Text("Clear text field"),
//       color: Colors.grey);
//
//   RaisedButton _getStateButton() => RaisedButton(
//       onPressed: () {
//         new Logger().log(Level.info, rtcPeerToPeer.getState().toString());
//       },
//       child: Text("Get State"),
//       color: Colors.indigoAccent);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Call Screen"),
//       ),
//       body: Container(
//           child: ListView(
//         children: [
//           _videoRenderers(),
//           _offerAndAnswerButtons(),
//           _sdpCandidateTF(),
//           _sdpCandidateButtons(),
//           _disposeButton(),
//           _clearSdpControllerButton(),
//           _getStateButton()
//         ],
//       )),
//     );
//   }
// }
