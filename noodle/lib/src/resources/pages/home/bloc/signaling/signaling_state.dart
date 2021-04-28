import 'package:equatable/equatable.dart';
import 'package:noodle/src/core/models/signaling_status.dart';

class SignalingState extends Equatable {
  const SignalingState._({
    this.status = SignalingStatus.Unknown,
  });

  const SignalingState.unknown() : this._();

  final SignalingStatus status;

  @override
  List<dynamic> get props => [status];
}
