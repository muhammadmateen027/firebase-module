import 'package:formz/formz.dart';

/// Sms code Form Input Validation Error
enum CodeValidationError {
  /// Code is invalid (generic validation error)
  invalid
}

/// {@template code}
/// Reusable code form input.
/// {@endtemplate}
class Code extends FormzInput<String, CodeValidationError> {
  /// {@macro code}
  const Code.pure() : super.pure('');

  /// {@macro code}
  const Code.dirty([String value = '']) : super.dirty(value);

  @override
  CodeValidationError? validator(String value) {
    return value.length == 6 ? null : CodeValidationError.invalid;
  }
}
