import 'package:formz/formz.dart';

/// Unique user handle Form Input Validation Error
enum UsernameValidationError {
  /// Unique user handle is invalid (generic validation error)
  invalid
}

/// {@template Unique user handle}
/// Reusable Unique user handle form input.
/// {@endtemplate}
class Handle extends FormzInput<String, UsernameValidationError> {
  /// {@macro Unique user handle}
  const Handle.pure() : super.pure('');

  /// {@macro Unique user handle}
  const Handle.dirty([String value = '']) : super.dirty(value);

  //Previous regex pattern for validation
  // static final RegExp _handleRegExp = RegExp(r'^([A-z_]\w+)+$');
  static final RegExp _handleRegExp =
      RegExp(r'^[A-zñ0-9_.-]*[a-zA-Z][A-zñ0-9_.-]*$');

  @override
  UsernameValidationError? validator(String value) {
    return _handleRegExp.hasMatch(value) &&
            value.length < 24 &&
            value.length > 2
        ? null
        : UsernameValidationError.invalid;
  }
}
