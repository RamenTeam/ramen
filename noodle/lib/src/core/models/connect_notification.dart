import 'package:equatable/equatable.dart';
import 'package:noodle/src/core/models/user.dart';

class ConnectionNotification extends Equatable {
  ConnectionNotification({
    this.id = "",
    required this.from,
    this.read = false,
    this.createdAt = "",
    this.label = "",
    this.status = ConnectionStatus.Pending,
  });

  final String id;
  late User from;
  final bool read;
  final String label;
  final String createdAt;
  final ConnectionStatus status;

  @override
  // TODO: implement props
  List<Object?> get props => [id, from, read, label, createdAt, status];
}

enum ConnectionStatus {
  Pending,
  Accepted,
  Rejected,
}
