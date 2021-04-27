import 'package:noodle/src/core/utils/rtc_type.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:socket_io_client/socket_io_client.dart' as IO;

const CLIENT_ID_EVENT = 'client-id-event';
const OFFER_EVENT = 'offer-event';
const ANSWER_EVENT = 'answer-event';
const ICE_CANDIDATE_EVENT = 'ice-candidate-event';

class RamenWebSocket {
  final String url;
  late IO.Socket socket;
  late OnOpenCallback onOpen;
  late OnMessageCallback onMessage;
  late OnCloseCallback onClose;

  RamenWebSocket({required this.url});

  connect() async {
    try {
      socket = IO.io(url, <String, dynamic>{
        'transports': ['websocket']
      });

      socket.on('connect', (_) {
        print('connected');
        onOpen();
      });

      socket.on('exception', (e) => print('Exception: $e'));

      socket.on('connect_error', (e) => print('Connect error: $e'));

      socket.on('disconnect', (e) {
        print('disconnect');
        onClose(0, e);
      });

      socket.on('fromServer', (_) => print(_));

      // TODO !important logic
      socket.on(CLIENT_ID_EVENT, (data) => onMessage(CLIENT_ID_EVENT, data));

      socket.on(ANSWER_EVENT, (data) => onMessage(ANSWER_EVENT, data));

      socket.on(OFFER_EVENT, (data) => onMessage(OFFER_EVENT, data));

      socket.on(
          ICE_CANDIDATE_EVENT, (data) => onMessage(ICE_CANDIDATE_EVENT, data));
    } catch (e) {
      this.onClose(500, e.toString());
    }
  }

  send(event, data) {
    socket.emit(event, data);
    print('send: $event - $data');
  }

  close() {
    socket.close();
  }
}
