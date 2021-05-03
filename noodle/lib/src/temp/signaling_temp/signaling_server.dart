import 'package:noodle/src/core/config/rtc_signaling.dart';
import 'package:noodle/src/temp/rtc_temp/rtc_sandbox.dart';

class MockSignalingServer {
  final RTCSignaling rtcSignaling =
      new RTCSignaling(host: "127.0.0.1", port: 3000);

  RTCSandBox _rtcSandBox = new RTCSandBox();

  connect() {
    _rtcSandBox.initRenderer();
    _rtcSandBox.createPC().then((pc) => _rtcSandBox.setPeerConnection(pc));
    rtcSignaling.connect();
  }

  disconnect() {
    rtcSignaling.disconnect();
  }

  offer() async {
    String description = await _rtcSandBox.offer();
    rtcSignaling.emitOfferEvent(description);
  }

  answer() {}
}
