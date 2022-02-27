import 'package:formz/formz.dart';

/// Password Form Input Validation Error
enum PasswordValidationError {
  /// Password is invalid (generic validation error)
  invalid
}

/// {@template password}
/// Reusable password form input.
/// {@endtemplate}
class Password extends FormzInput<String, PasswordValidationError> {
  /// {@macro password}
  const Password.pure() : super.pure('');

  /// {@macro password}
  const Password.dirty([String value = '']) : super.dirty(value);

  // Minimum 1 Upper case
  // Minimum 1 lowercase
  // Minimum 1 Numeric Number or 1 Special Character
  // Common Allow Character ( ! @ # $ & * ~ )
  static final _passwordRegExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])((?=.*?[0-9]|)|(?=.*?[!@#\$&*~%^":;?><`])).{8,}$',
  );

  @override
  PasswordValidationError? validator(String value) {
    return _passwordRegExp.hasMatch(value)
        ? null
        : PasswordValidationError.invalid;
  }
}
