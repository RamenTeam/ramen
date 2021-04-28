// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';
import 'package:noodle/src/core/models/matching_status.dart';

abstract class MatchingEvent extends Equatable {
  MatchingEvent();

  @override
  List<Object> get props => [];
}

class MatchingStatusChanged extends MatchingEvent {
  MatchingStatusChanged(this.status);

  final MatchingStatus status;

  @override
  List<Object> get props => [status];
}
