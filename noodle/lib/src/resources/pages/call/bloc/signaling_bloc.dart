import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/constants/global_variables.dart';
import 'package:noodle/src/core/config/rtc_signaling.dart';
import 'package:noodle/src/core/models/signaling_status.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/repositories/sharedpreference_repository.dart';
import 'package:noodle/src/resources/pages/call/bloc/signaling_event.dart';
import 'package:noodle/src/resources/pages/call/bloc/signaling_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignalingBloc extends Bloc<SignalingEvent, SignalingState> {
  SignalingBloc() : super(const SignalingState.idling());

  late StreamSubscription<SignalingStatus> _signalingStatusSubscription;

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
    _signalingStatusSubscription.cancel();
    return super.close();
  }

  Stream<SignalingState> _mapSignalingStatusChangedToState(
    SignalingStatusChanged event,
  ) async* {
    SharedPreferences _pref = await getSharedPref();
    print(event.status);
    switch (event.status) {
      case SignalingStatus.FINDING:
        print("🎐🎐🎐 FINDING");
        yield SignalingState.finding();
        break;
      case SignalingStatus.MATCHING:
        print("🎐🎐🎐 MATCHING");
        yield SignalingState.matching(User.empty);
        break;
      case SignalingStatus.DISCONNECTED:
        print("🎐🎐🎐 DISCONNECTED");
        _pref.remove(RTC_CLIENT_ID);
        _pref.remove(RTC_CANDIDATE);
        _pref.remove(RTC_HOST_ID);
        _pref.remove(RTC_PEER_ID);
        yield SignalingState.unknown();
        break;
      case SignalingStatus.NO_PEER_FOUND:
        print("🎐🎐🎐 NO_PEER_FOUND");
        yield SignalingState.notFound();
        break;
      case SignalingStatus.IDLE:
        print("🎐🎐🎐 IDLE");
        yield SignalingState.idling();
        break;
      default:
        yield const SignalingState.idling();
    }
  }

  Future<User?> getPeer() async {
    User mockData = User(
        id: "123",
        email: "email@net.com",
        username: "Tin Chung",
        bio: "Hello World",
        phoneNumber: "123123123",
        firstName: "Tin",
        lastName: "Chung",
        avatarPath:
            "https://th.bing.com/th/id/OIP.xzIfQQCZiBpvccxSZUsOSAHaHa?pid=ImgDet&rs=1");

    User? _user;
    if (_user != null) return _user;
    return Future.delayed(
        const Duration(milliseconds: 3000), () => _user = null);
  }
}
