import 'package:formz/formz.dart';

/// Phone Form Input Validation Error
enum PhoneValidationError {
  /// Phone is invalid (generic validation error)
  invalid
}

/// {@template phone}
/// Reusable phone form input.
/// {@endtemplate}
class Phone extends FormzInput<String, PhoneValidationError> {
  /// {@macro phone}
  const Phone.pure() : super.pure('');

  /// {@macro phone}
  const Phone.dirty([String value = '']) : super.dirty(value);

  @override
  PhoneValidationError? validator(String value) {
    return value != '' ? null : PhoneValidationError.invalid;
  }
}
