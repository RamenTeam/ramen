import 'package:equatable/equatable.dart';
import 'package:noodle/src/core/models/connect_notification.dart';

class NotificationState extends Equatable {
  final List<ConnectionNotification> notifications;

  NotificationState({required this.notifications});

  @override
  // TODO: implement props
  List<Object> get props => [notifications];
}
