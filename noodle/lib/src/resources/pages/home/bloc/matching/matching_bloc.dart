import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/config/rtc_signaling.dart';
import 'package:noodle/src/core/models/matching_status.dart';
import 'package:noodle/src/core/models/user.dart';
import 'package:noodle/src/resources/pages/home/bloc/matching/matching_event.dart';
import 'package:noodle/src/resources/pages/home/bloc/matching/matching_state.dart';

class MatchingBloc extends Bloc<MatchingEvent, MatchingState> {
  MatchingBloc() : super(const MatchingState.idling());

  late StreamSubscription<MatchingStatus> _matchingStatusSubscription;

  RTCSignaling? _signaling;

  @override
  Stream<MatchingState?> mapEventToState(
    MatchingEvent event,
  ) async* {
    if (event is MatchingStatusChanged) {
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

  Stream<MatchingState> _mapMatchingStatusChangedToState(
    MatchingStatusChanged event,
  ) async* {
    print(event.status);
    switch (event.status) {
      case MatchingStatus.ABORTING: // TODO Temporarily
        yield const MatchingState.aborting(User.empty);
        break;
      case MatchingStatus.FINDING: // TODO Temporarily
        /* Need to cancel the asynchronous function when being IDLE */
        add(MatchingStatusChanged(MatchingStatus.PEER_REQUEST));
        yield MatchingState.finding();
        break;
      case MatchingStatus.DONE: // TODO Temporarily
        yield const MatchingState.idling();
        break;
      case MatchingStatus.MATCHING: // TODO Temporarily
        yield const MatchingState.matching(User.empty);
        break;
      case MatchingStatus.PEER_REQUEST: // TODO Temporarily
        User? peer = await getPeer();
        yield peer == null
            ? MatchingState.notFound()
            : MatchingState.matching(peer);
        break;
      case MatchingStatus.IDLE:
        yield MatchingState.idling();
        break;
      default:
        yield const MatchingState.idling();
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
