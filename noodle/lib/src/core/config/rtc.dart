import 'package:noodle/src/core/config/rtc_p2p.dart';
import 'package:noodle/src/core/config/rtc_signaling.dart';

const String LOCAL = "127.0.0.1";
const String REMOTE = "ramen-kansui.herokuapp.com/";
final RTCSignaling rtcSignaling =
    new RTCSignaling(host: REMOTE, port: 3000, isProd: true);

final RTCPeerToPeer rtcPeerToPeer = new RTCPeerToPeer();
