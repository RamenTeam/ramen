import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noodle/src/core/models/connect_notification.dart';
import 'package:noodle/src/core/repositories/notification_repository.dart';
import 'package:noodle/src/resources/pages/notifications/bloc/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository notificationRepository;

  NotificationCubit({required this.notificationRepository}) : super(NotificationState(notifications: []));

  List<ConnectionNotification> getNotifications() {
    return state.notifications;
  }

  Future<void> fetchNotifications() async {
    List<ConnectionNotification> notifications =
        await notificationRepository.getMyNotifications();
    emit(NotificationState(notifications: notifications));
  }
}
