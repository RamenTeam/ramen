import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:noodle/src/core/models/form/email.dart';
import 'package:noodle/src/core/models/form/password.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(shouldValidate: false),
      this.status = FormzStatus.pure,
      this.responseMessage = "",
      this.success = false});

  final Email email;
  final Password password;
  final FormzStatus status;
  final String responseMessage;
  final bool success;

  @override
  List<Object> get props => [email, password, status, responseMessage, success];

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? responseMessage,
    bool? success,
  }) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        responseMessage: responseMessage ?? this.responseMessage,
        success: success ?? this.success);
  }
}
