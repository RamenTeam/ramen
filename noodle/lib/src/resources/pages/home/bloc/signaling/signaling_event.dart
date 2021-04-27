// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';
import 'file:///D:/Projects/ramen/noodle/lib/src/resources/pages/home/bloc/matching/matching_state.dart';
import 'file:///D:/Projects/ramen/noodle/lib/src/resources/pages/home/bloc/signaling/signaling_status.dart';

abstract class SignalingEvent extends Equatable {
  SignalingEvent();

  @override
  List<Object> get props => [];
}

class SignalingStatusChanged extends SignalingEvent {
  SignalingStatusChanged(this.status);

  final SignalingStatus status;

  @override
  List<Object> get props => [status];
}
