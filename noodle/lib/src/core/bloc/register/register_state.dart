import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  RegisterState({this.errorMessage = "", this.success = false});

  final String errorMessage;
  final bool success;

  @override
  List<Object> get props => [errorMessage];
}
