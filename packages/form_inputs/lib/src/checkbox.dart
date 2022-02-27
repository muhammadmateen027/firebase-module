import 'package:formz/formz.dart';

/// Checkbox Form Input Validation Error
enum CheckboxValidationError {
  /// Checkbox is invalid (generic validation error)
  invalid
}

/// {@template checkbox}
/// Reusable checkbox form input.
/// {@endtemplate}
class FormCheckbox extends FormzInput<bool, CheckboxValidationError> {
  /// {@macro checkbox}
  const FormCheckbox.pure() : super.pure(false);

  /// {@macro checkbox}
  const FormCheckbox.dirty([bool value = false]) : super.dirty(value);

  @override
  CheckboxValidationError? validator(bool value) {
    return value ? null : CheckboxValidationError.invalid;
  }
}
