import 'package:formz/formz.dart';

/// Basic info Form Input Validation Error
enum BasicInfoValidation {
  /// Basic info is invalid (generic validation error)
  invalid
}

/// {@template basic info}
/// Reusable basic info form input.
/// {@endtemplate}
class BasicInfo extends FormzInput<String, BasicInfoValidation> {
  /// {@macro text}
  const BasicInfo.pure() : super.pure('');

  /// {@macro text}
  const BasicInfo.dirty([String value = '']) : super.dirty(value);

  @override
  BasicInfoValidation? validator(String value) {
    return (value.isNotEmpty) ? null : BasicInfoValidation.invalid;
  }
}
