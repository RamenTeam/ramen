import 'package:noodle/src/core/config/rtc.dart';
import 'package:noodle/src/core/config/rtc_signaling.dart';

class MockSignalingServer {
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
