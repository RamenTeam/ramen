import 'dart:convert';

import 'package:noodle/src/constants/global_variables.dart';
import 'package:noodle/src/constants/os.dart';
import 'package:noodle/src/core/config/rtc.dart';
import 'package:noodle/src/core/config/websocket_client.dart';
import 'package:noodle/src/core/repositories/sharedpreference_repository.dart';
import 'package:noodle/src/core/utils/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    SharedPreferences pref = await getSharedPref();
    switch (tag) {
      // #0
      case CLIENT_ID_EVENT:
        print("CLIENT_ID_EVENT 🔔");
        dynamic data = message["data"];
        PersistentStorage.setRTCClient(data["clientId"]);
        break;
      // #1
      case MATCHMAKING_EVENT:
        print("MATCHMAKING_EVENT 🔔");
        dynamic data = message["data"];
        if (data["peer"] == null) {
          return;
        }
        String description = await rtcPeerToPeer.offer();
        emitOfferEvent(data["peer"], description);
        break;
      // #2
      case OFFER_EVENT:
        print("OFFER_EVENT 🔔");
        dynamic data = message["data"];
        rtcPeerToPeer.setRemoteDescription(data["description"], "offer");
        String description = await rtcPeerToPeer.answer();
        emitAnswerEvent(data["host"], description);
        break;
      // #3
      case ANSWER_EVENT:
        print("ANSWER_EVENT 🔔");
        dynamic data = message["data"];
        rtcPeerToPeer.setRemoteDescription(data["description"], "answer");
        // TODO Set Ice Candidate
        break;
      // #4
      case ICE_CANDIDATE_EVENT:
        print("ICE_CANDIDATE_EVENT 🔔");
        break;
    }
  }

  _send(event, data) {
    _socket?.send(event, data);
  }

  emitOfferEvent(peerId, description) {
    _send(OFFER_EVENT, {'peerId': peerId, 'description': description});
  }

  emitAnswerEvent(hostId, description) {
    _send(ANSWER_EVENT, {'hostId': hostId, 'description': description});
  }

  emitIceCandidateEvent(isHost, candidate) {
    _send(ICE_CANDIDATE_EVENT, {'isHost': isHost, 'candidate': candidate});
  }
}
