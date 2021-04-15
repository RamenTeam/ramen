import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterError extends RegisterEvent {
  RegisterError({required this.errorMessage});

  final String errorMessage;
}

class RegisterSuccess extends RegisterEvent {}
