import 'package:noodle/src/core/config/rtc.dart';
import 'package:noodle/src/core/config/rtc_signaling.dart';
import 'package:noodle/src/temp/rtc_temp/rtc_sandbox.dart';

class MockSignalingServer {
  final RTCSignaling rtcSignaling =
      new RTCSignaling(host: "127.0.0.1", port: 3000);

  connect() {
    rtcSignaling.connect();
  }

  disconnect() {
    rtcSignaling.disconnect();
  }

  setCandidate(String jsonString) {
    rtcPeerToPeer.setCandidate(jsonString);
  }
}
