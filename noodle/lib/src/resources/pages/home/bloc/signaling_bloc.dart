import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/config/rtc_signaling.dart';
import 'package:noodle/src/resources/pages/home/bloc/signaling_event.dart';
import 'package:noodle/src/resources/pages/home/bloc/signaling_state.dart';
import 'package:noodle/src/resources/pages/home/bloc/signaling_status.dart';

class SignalingBloc extends Bloc<SignalingEvent, SignalingState> {
  SignalingBloc() : super(SignalingState.unknown());

  late StreamSubscription<SignalingStatus> _matchingStatusSubscription;

  RTCSignaling? _signaling;

  @override
  Stream<SignalingState?> mapEventToState(
    SignalingEvent event,
  ) async* {
    if (event is SignalingStatusChanged) {
      yield* _mapMatchingStatusChangedToState(event);
      print(state.props);
      yield state;
    }
  }

  @override
  Future<void> close() {
    _matchingStatusSubscription.cancel();
    return super.close();
  }

  Stream<SignalingState> _mapMatchingStatusChangedToState(
    SignalingStatusChanged event,
  ) async* {
    print(event.status);
    switch (event.status) {
      case SignalingStatus.CallStateBye:
        break;
      case SignalingStatus.CallStateConnected:
        break;
      case SignalingStatus.CallStateInvite:
        break;
      case SignalingStatus.CallStateNew:
        break;
      case SignalingStatus.CallStateRinging:
        break;
      default:
        yield const SignalingState.unknown();
    }
  }

  void _connect() async {
    String serverIP = await _searchForIp();
    if (_signaling == null) {
      _signaling = RTCSignaling(serverIP)..connect();
    }
  }

  Future<String> _searchForIp() async {
    return "";
  }
}
