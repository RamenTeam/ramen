import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:noodle/src/core/models/form/confirmed_password.dart';
import 'package:noodle/src/core/models/form/email.dart';
import 'package:noodle/src/core/models/form/name.dart';
import 'package:noodle/src/core/models/form/password.dart';
import 'package:noodle/src/core/models/form/phone_number.dart';
import 'package:noodle/src/core/models/form/username.dart';

enum ConfirmPasswordValidationError { invalid }

class RegisterState extends Equatable {
  const RegisterState({
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.responseMessage = "",
    this.success = false,
  });

  final Name firstName;
  final Name lastName;
  final Username username;
  final Email email;
  final PhoneNumber phoneNumber;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final String responseMessage;
  final bool success;

  @override
  List<Object> get props => [
        firstName,
        lastName,
        username,
        email,
        phoneNumber,
        password,
        confirmedPassword,
        status,
        responseMessage,
        success
      ];

  RegisterState copyWith({
    Name? firstName,
    Name? lastName,
    Username? username,
    Email? email,
    PhoneNumber? phoneNumber,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    String? responseMessage,
    bool? success,
  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      responseMessage: responseMessage ?? this.responseMessage,
      success: success ?? this.success,
    );
  }
}
