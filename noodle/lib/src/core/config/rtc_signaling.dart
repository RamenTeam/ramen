import 'package:noodle/src/constants/global_variables.dart';
import 'package:noodle/src/constants/os.dart';
import 'package:noodle/src/core/config/rtc.dart';
import 'package:noodle/src/core/config/websocket_client.dart';
import 'package:noodle/src/core/models/signaling_status.dart';
import 'package:noodle/src/core/repositories/sharedpreference_repository.dart';
import 'package:noodle/src/core/utils/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef void SignalingStateCallback(SignalingStatus state);

class RTCSignaling {
  RamenWebSocket? _socket;
  SignalingStateCallback? onStateChange;

  final String host;

  final dynamic port;

  final bool isProd;

  RTCSignaling({required this.host, required this.port, required this.isProd});

  void disconnect() async {
    if (_socket != null) {
      await _socket?.disconnect();
    } else {
      print("You must connect to server first!");
    }
  }

  void connect() async {
    String url = isProd ? "https://$host" : 'http://$host:$port';
    _socket = new RamenWebSocket(url: url);
    print("Ramen WebSocket is connecting...");

    _socket?.onOpen = () {
      print("[🔫 TRIGGERED_EVENT] onOpen");
      this.onStateChange!(SignalingStatus.IDLE);
      // if (!isWeb) {
      //   print({'name': DeviceInfo.label, 'user_agent': DeviceInfo.userAgent});
      // }
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
      this.onStateChange!(SignalingStatus.DISCONNECTED);
      // TODO Handling signaling_state_changed !
    };

    print('🚀 Connect to $url');

    await _socket?.connect();
  }

  Future<bool> _isServerIdentity(
      {required dynamic data, required String type}) async {
    SharedPreferences pref = await getSharedPref();

    return pref.get(RTC_CLIENT_ID) != null &&
        pref.get(RTC_CLIENT_ID) == data["host"];
  }

  void onMessage(tag, message) async {
    SharedPreferences pref = await getSharedPref();
    switch (tag) {
      // #0
      case CLIENT_ID_EVENT:
        print("CLIENT_ID_EVENT 🔔");
        this.onStateChange!(SignalingStatus.FINDING);
        dynamic data = message["data"];
        PersistentStorage.setRTCClient(data["clientId"]);
        break;
      // #1
      case MATCHMAKING_EVENT:
        print("MATCHMAKING_EVENT 🔔");
        this.onStateChange!(SignalingStatus.MATCHING);
        dynamic data = message["data"];
        PersistentStorage.setRTCRoom(data["host"], data["peer"]);
        if (data["peer"] == null) {
          return;
        }
        if (await _isServerIdentity(data: data, type: "host")) {
          String description = await rtcPeerToPeer.offer();
          // Step 3: caller sends the description to the callee
          emitOfferEvent(data["peer"], description);
        }
        break;
      // #2
      case OFFER_EVENT:
        print("OFFER_EVENT 🔔");
        dynamic data = message["data"];
        // Step 4: callee receives the offer sets remote description
        rtcPeerToPeer.setRemoteDescription(data["description"], "offer");
        print(await rtcPeerToPeer.peerConnection.getLocalDescription());
        String description = await rtcPeerToPeer.answer();
        // Step 7: callee send the description to caller
        emitAnswerEvent(pref.get(RTC_HOST_ID), description);
        break;
      // #3
      case ANSWER_EVENT:
        print("ANSWER_EVENT 🔔");
        dynamic data = message["data"];
        // Step 8: caller receives the answer and sets remote description
        rtcPeerToPeer.setRemoteDescription(data["description"], "answer");
        Future.delayed(const Duration(milliseconds: 1000), () {
          dynamic retryInterval = 0;
          while (retryInterval < 5) {
            dynamic candidate = pref.get(RTC_CANDIDATE);
            if (candidate != null) {
              emitIceCandidateEvent(true, candidate);
              break;
            } else {
              print("Cannot find candidate");
              retryInterval += 1;
            }
          }
        });
        break;
      // #4
      case ICE_CANDIDATE_EVENT:
        print("ICE_CANDIDATE_EVENT 🔔");
        dynamic data = message["data"];
        print(data["candidate"]);
        rtcPeerToPeer.setCandidate(data["candidate"]);
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
