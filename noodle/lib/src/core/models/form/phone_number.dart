import 'package:formz/formz.dart';

enum PhoneNumberValidationError { invalid }

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure() : super.pure('');

  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  static final RegExp _phoneRegExp = RegExp(
      r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$');

  @override
  PhoneNumberValidationError? validator(String value) {
    return _phoneRegExp.hasMatch(value)
        ? null
        : PhoneNumberValidationError.invalid;
  }
}
