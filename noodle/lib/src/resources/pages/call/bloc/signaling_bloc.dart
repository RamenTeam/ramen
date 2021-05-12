import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/constants/global_variables.dart';
import 'package:noodle/src/core/models/signaling_status.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/core/repositories/sharedpreference_repository.dart';
import 'package:noodle/src/core/repositories/user_repository.dart';
import 'package:noodle/src/resources/pages/call/bloc/signaling_event.dart';
import 'package:noodle/src/resources/pages/call/bloc/signaling_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignalingBloc extends Bloc<SignalingEvent, SignalingState> {
  SignalingBloc() : super(const SignalingState.idling());

  final UserRepository userRepository = new UserRepository();
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
        print("User: ");
        User? user = await getPeer();
        print(user);
        if (user == null) {
          yield SignalingState.matching(User.empty);
        } else {
          yield SignalingState.matching(user);
        }
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
    SharedPreferences pref = await getSharedPref();
    User mockData = User(
        id: "123",
        username: "anonymous",
        bio: "Hello World",
        phoneNumber: "666666",
        firstName: "Anonymous",
        lastName: "Guy",
        avatarPath: "https://avatarfiles.alphacoders.com/853/85389.jpg");

    if (pref.get(RTC_PEER_ID) != null) {
      User? _user = await userRepository.getUserById(pref.get(RTC_PEER_ID));
      if (_user != null) return _user;
    }
    return mockData;
  }
}
