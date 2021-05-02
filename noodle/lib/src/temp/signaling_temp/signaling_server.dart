import 'package:noodle/src/core/config/rtc_signaling.dart';

class MockSignalingServer {
  final RTCSignaling rtcSignaling =
      new RTCSignaling(host: "127.0.0.1", port: 3000);

  connect() {
    rtcSignaling.connect();
  }

  disconnect() {
    rtcSignaling.disconnect();
  }
}
