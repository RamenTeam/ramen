import 'package:equatable/equatable.dart';
import 'package:noodle/src/core/models/signaling_status.dart';
import 'package:noodle/src/core/models/user.dart';

class SignalingState extends Equatable {
  const SignalingState._({
    this.status = SignalingStatus.IDLE,
    this.peer = User.empty,
  });

  const SignalingState.unknown() : this._();

  const SignalingState.finding() : this._(status: SignalingStatus.FINDING);

  const SignalingState.matching(User peer)
      : this._(status: SignalingStatus.MATCHING, peer: peer);

  const SignalingState.idling() : this._(status: SignalingStatus.IDLE);

  const SignalingState.notFound()
      : this._(status: SignalingStatus.NO_PEER_FOUND);

  final SignalingStatus status;
  final User? peer;

  @override
  List<dynamic> get props => [status, peer];
}
