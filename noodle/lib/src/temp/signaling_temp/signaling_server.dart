import 'package:noodle/src/core/config/rtc.dart';

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
