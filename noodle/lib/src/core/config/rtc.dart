import 'package:noodle/src/core/config/rtc_p2p.dart';
import 'package:noodle/src/core/config/rtc_signaling.dart';

final RTCSignaling rtcSignaling =
    new RTCSignaling(host: "127.0.0.1", port: 3000);

final RTCPeerToPeer rtcPeerToPeer = new RTCPeerToPeer();
