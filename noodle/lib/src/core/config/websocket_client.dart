import 'package:noodle/src/constants/global_variables.dart';
import 'package:noodle/src/core/repositories/sharedpreference_repository.dart';
import 'package:noodle/src/core/utils/rtc_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:socket_io_client/socket_io_client.dart' as IO;

const CLIENT_ID_EVENT = 'client-id-event';
const OFFER_EVENT = 'offer-event';
const ANSWER_EVENT = 'answer-event';
const ICE_CANDIDATE_EVENT = 'ice-candidate-event';
const MATCHMAKING_EVENT = "matchmaking-event";

class RamenWebSocket {
  final String url;
  IO.Socket? socket;
  late OnOpenCallback onOpen;
  late OnMessageCallback onMessage;
  late OnCloseCallback onClose;

  RamenWebSocket({required this.url});

  connect() async {
    SharedPreferences pref = await getSharedPref();
    try {
      socket = IO.io(url, <String, dynamic>{
        'transports': ['websocket'],
        'query': "userId=${pref.get(USER_ID_KEY) ?? null}"
      });

      if (socket!.connected) {
        print("⚠ Client is connected already!!!!");
      }
      socket!.on('connect', (_) {
        print('connected');
        onOpen();
      });

      socket!.on('exception', (e) => print('Exception: $e'));

      socket!.on('connect_error', (e) => print('Connect error: $e'));

      socket!.on('disconnect', (e) {
        print('disconnect');
        onClose(0, e);
      });

      socket!.on('fromServer', (_) => print(_));

      // TODO !important logic
      socket!.on(CLIENT_ID_EVENT, (data) => onMessage(CLIENT_ID_EVENT, data));

      socket!.on(ANSWER_EVENT, (data) => onMessage(ANSWER_EVENT, data));

      socket!.on(OFFER_EVENT, (data) => onMessage(OFFER_EVENT, data));

      socket!.on(
          ICE_CANDIDATE_EVENT, (data) => onMessage(ICE_CANDIDATE_EVENT, data));

      socket!
          .on(MATCHMAKING_EVENT, (data) => onMessage(MATCHMAKING_EVENT, data));

      socket?.connect();
    } catch (e) {
      this.onClose(500, e.toString());
    }
  }

  send(event, data) {
    if (socket != null) {
      socket!.emit(event, data);
      print('send: $event - $data');
    }
  }

  close() {
    socket!.dispose();
  }

  reconnect() {
    socket!
      ..disconnect()
      ..connect();
  }

  disconnect() {
    socket!.dispose();
  }
}
