import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/bloc/matching/matching_event.dart';
import 'package:noodle/src/core/bloc/matching/matching_state.dart';
import 'package:noodle/src/core/models/user.dart';

class MatchingBloc extends Bloc<MatchingEvent, MatchingState> {
  MatchingBloc() : super(const MatchingState.idling());

  late StreamSubscription<MatchingStatus> _matchingStatusSubscription;

  @override
  Stream<MatchingState?> mapEventToState(
    MatchingEvent event,
  ) async* {
    if (event is MatchingStatusChanged) {
      MatchingState state = await _mapMatchingStatusChangedToState(event);
      print(state.props);
      yield state;
    }
  }

  @override
  Future<void> close() {
    _matchingStatusSubscription.cancel();
    return super.close();
  }

  Future<MatchingState> _mapMatchingStatusChangedToState(
    MatchingStatusChanged event,
  ) async {
    print(event.status);
    switch (event.status) {
      case MatchingStatus.ABORTING: // TODO Temporarily
        return const MatchingState.aborting(User.empty);
      case MatchingStatus.FINDING: // TODO Temporarily
        bool mockCond = true;
        Timer(Duration(seconds: 5), () {
          mockCond = false;
        });
        return mockCond
            ? MatchingState.finding()
            : MatchingState.matching(User.empty);
      case MatchingStatus.DONE: // TODO Temporarily
        return const MatchingState.idling();
      case MatchingStatus.MATCHING: // TODO Temporarily
        return const MatchingState.matching(User.empty);
      default:
        return const MatchingState.idling();
    }
  }
}
