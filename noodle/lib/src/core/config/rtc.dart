import 'package:noodle/src/core/config/rtc_p2p.dart';
import 'package:noodle/src/core/config/rtc_signaling.dart';

const bool isProd = false;
const String URL = isProd ? "ramen-kansui.herokuapp.com/" : "127.0.0.1";
const dynamic port = 3000;
final RTCSignaling rtcSignaling =
    new RTCSignaling(host: URL, port: port, isProd: isProd);

final RTCPeerToPeer rtcPeerToPeer = new RTCPeerToPeer();
