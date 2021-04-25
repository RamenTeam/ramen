import 'package:formz/formz.dart';

enum BioValidationError { MaxCharacterExceeded }

class Bio extends FormzInput<String, BioValidationError> {
  const Bio.pure() : super.pure('');

  const Bio.dirty([String value = '']) : super.dirty(value);

  @override
  BioValidationError? validator(String value) {
    return value.length < 500 ? null : BioValidationError.MaxCharacterExceeded;
  }
}
