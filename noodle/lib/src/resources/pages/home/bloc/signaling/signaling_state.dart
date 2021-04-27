import 'package:equatable/equatable.dart';
import 'file:///D:/Projects/ramen/noodle/lib/src/resources/pages/home/bloc/signaling/signaling_status.dart';

class SignalingState extends Equatable {
  const SignalingState._({
    this.status = SignalingStatus.Unknown,
  });

  const SignalingState.unknown() : this._();

  final SignalingStatus status;

  @override
  List<dynamic> get props => [status];
}
