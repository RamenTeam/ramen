import 'package:noodle/src/constants/os.dart';
import 'package:noodle/src/core/config/websocket_client.dart';
import 'package:noodle/src/core/utils/device_info.dart';

class RTCSignaling {
  RamenWebSocket? _socket;

  final String host;

  final dynamic port;

  RTCSignaling({required this.host, required this.port});

  void disconnect() async {
    if (_socket != null) {
      await _socket?.disconnect();
    } else {
      print("You must connect to server first!");
    }
  }

  void connect() async {
    String url = 'http://$host:$port';
    _socket = new RamenWebSocket(url: url);
    print("Ramen WebSocket is connecting...");

    _socket?.onOpen = () {
      print("[🔫 TRIGGERED_EVENT] onOpen");
      if (!isWeb) {
        print({'name': DeviceInfo.label, 'user_agent': DeviceInfo.userAgent});
      }
      // TODO Handling signaling_state_changed !
    };

    _socket?.onMessage = (tag, message) {
      print('Received data: $tag - $message');
      this.onMessage(tag, message);
    };

    _socket?.onClose = (int code, String reason) {
      print("[🔫 TRIGGERED_EVENT] onClose");
      print('Closed by server [$code => $reason]!');
      _socket = null;
      // TODO Handling signaling_state_changed !
    };

    print('🚀 Connect to $url');

    await _socket?.connect();
  }

  void onMessage(tag, message) async {
    switch (tag) {
      case CLIENT_ID_EVENT:
        print("CLIENT_ID_EVENT 🔔");
        break;
      case ANSWER_EVENT:
        print("ANSWER_EVENT 🔔");
        break;
      case OFFER_EVENT:
        print("OFFER_EVENT 🔔");
        break;
      case ICE_CANDIDATE_EVENT:
        print("ICE_CANDIDATE_EVENT 🔔");
        break;
      case MATCHMAKING_EVENT:
        print("MATCHING_MAKING_EVENT 🔔");
        break;
    }
  }

  _send(event, data) {
    _socket?.send(event, data);
  }

  emitOfferEvent(description) {
    _send(OFFER_EVENT, {'description': description});
  }

  emitAnswerEvent(description) {
    _send(ANSWER_EVENT, {'description': description});
  }

  emitIceCandidateEvent(isHost, candidate) {
    _send(ICE_CANDIDATE_EVENT, {'isHost': isHost, 'candidate': candidate});
  }
}
