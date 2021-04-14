import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  LoginState({this.errorMessage = ""});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
