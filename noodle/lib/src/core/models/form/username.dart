import 'package:formz/formz.dart';

enum UsernameValidationError { invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');

  const Username.dirty([String value = '']) : super.dirty(value);

  static final RegExp _usernameRegExp = RegExp(r"^[A-Za-z0-9_]+$");

  @override
  UsernameValidationError? validator(String value) {
    return _usernameRegExp.hasMatch(value)
        ? null
        : UsernameValidationError.invalid;
  }
}
