import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure({this.shouldValidate = true}) : super.pure('');

  const Password.dirty({this.shouldValidate = true, String value = ''})
      : super.dirty(value);

  final bool shouldValidate;

  @override
  PasswordValidationError? validator(String value) {
    if (shouldValidate)
      return value.length >= 6 ? null : PasswordValidationError.invalid;
    return value.isNotEmpty ? null : PasswordValidationError.invalid;
  }
}
