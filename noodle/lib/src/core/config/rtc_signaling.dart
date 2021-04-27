import 'package:noodle/src/core/config/websocket_client.dart';
import 'package:noodle/src/core/utils/device_info.dart';

class RTCSignaling {
  late RamenWebSocket _socket;

  final String _host;

  final dynamic _port = 3000;

  RTCSignaling(this._host);

  void connect() async {
    String url = 'http://$_host:$_port';
    _socket = new RamenWebSocket(url: url);
    print("Ramen WebSocket is connecting...");
    await _socket.connect();

    _socket.onOpen = () {
      print("[🔫 TRIGGERED_EVENT] onOpen");
      print({'name': DeviceInfo.label, 'user_agent': DeviceInfo.userAgent});
      // TODO Handling signaling_state_changed !
    };

    _socket.onMessage = (tag, message) {
      print('Received data: $tag - $message');
      this.onMessage(tag, message);
    };

    _socket.onClose = (int code, String reason) {
      print("[🔫 TRIGGERED_EVENT] onClose");
      print('Closed by server [$code => $reason]!');
      // TODO Handling signaling_state_changed !
    };

    print('🚀 Connect to $url');
  }

  void onMessage(tag, message) async {}
}
