import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  HomeState({this.status = HomeStatus.Idle});

  final HomeStatus status;

  @override
  // TODO: implement props
  List<Object> get props => [status];

  HomeState copyWith({
    HomeStatus? status,
  }) {
    return HomeState(
      status: status ?? this.status,
    );
  }
}

enum HomeStatus {
  Idle,
  Finding,
}
