import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginError extends LoginEvent {
  LoginError({required this.errorMessage});

  final String errorMessage;
}
