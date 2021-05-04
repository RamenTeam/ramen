import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/config/rtc_signaling.dart';
import 'package:noodle/src/core/models/signaling_status.dart';
import 'package:noodle/src/resources/pages/home/bloc/signaling/signaling_event.dart';
import 'package:noodle/src/resources/pages/home/bloc/signaling/signaling_state.dart';

class SignalingBloc extends Bloc<SignalingEvent, SignalingState> {
  SignalingBloc() : super(SignalingState.unknown());

  late StreamSubscription<SignalingStatus> _matchingStatusSubscription;

  RTCSignaling? _signaling;

  @override
  Stream<SignalingState?> mapEventToState(
    SignalingEvent event,
  ) async* {
    if (event is SignalingStatusChanged) {
      yield* _mapSignalingStatusChangedToState(event);
      print(state.props);
      yield state;
    }
  }

  @override
  Future<void> close() {
    _matchingStatusSubscription.cancel();
    return super.close();
  }

  Stream<SignalingState> _mapSignalingStatusChangedToState(
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
      case SignalingStatus.ConnectionOpen:
        break;
      case SignalingStatus.ConnectionClosed:
        break;
      case SignalingStatus.ConnectionError:
        break;
      default:
        yield const SignalingState.unknown();
    }
  }
}
