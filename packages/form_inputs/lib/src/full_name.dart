import 'package:formz/formz.dart';

/// Full Name Form Input Validation Error
enum FullNameValidation {
  /// Full Name is invalid (generic validation error)
  invalid
}

/// {@template full nme}
/// Reusable full name form input.
/// {@endtemplate}
class FullName extends FormzInput<String, FullNameValidation> {
  /// {@macro text}
  const FullName.pure() : super.pure('');

  /// {@macro text}
  const FullName.dirty([String value = '']) : super.dirty(value);

  @override
  FullNameValidation? validator(String value) {
    return (value.trim().isEmpty || value.trim().length > 24)
        ? FullNameValidation.invalid
        : null;
  }
}
