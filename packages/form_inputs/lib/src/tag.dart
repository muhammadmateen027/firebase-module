import 'package:formz/formz.dart';

/// Full Name Form Input Validation Error
enum TagValidation {
  /// Tag is invalid (generic validation error)
  invalid,

  /// Max character exceeded on [Tag]
  tooLarge,
}

/// {@template full nme}
/// Reusable full name form input.
/// {@endtemplate}
class Tag extends FormzInput<String, TagValidation> {
  /// {@macro text}
  const Tag.pure() : super.pure('');

  /// {@macro text}
  const Tag.dirty([String value = '']) : super.dirty(value);

  @override
  TagValidation? validator(String value) {
    final input = value.trim();
    if (input.length > 30) {
      return TagValidation.tooLarge;
    }
    if (!RegExp(r'^[a-z]*$').hasMatch(input)) {
      return TagValidation.invalid;
    }

    return null;
  }
}
