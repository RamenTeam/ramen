import 'package:equatable/equatable.dart';
import 'package:noodle/src/core/models/user.dart';

enum MatchingStatus { IDLE, FINDING, MATCHING, ABORTING, DONE }

class MatchingState extends Equatable {
  const MatchingState._({
    this.status = MatchingStatus.IDLE,
    this.peer = User.empty,
  });

  const MatchingState.unknown() : this._();

  const MatchingState.finding() : this._(status: MatchingStatus.FINDING);

  const MatchingState.aborting(User peer)
      : this._(status: MatchingStatus.ABORTING, peer: peer);

  const MatchingState.matching(User peer)
      : this._(status: MatchingStatus.MATCHING, peer: peer);

  const MatchingState.idling() : this._(status: MatchingStatus.IDLE);

  final MatchingStatus status;
  final User? peer;

  @override
  List<dynamic> get props => [status, peer?.id];
}
