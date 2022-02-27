import 'package:form_inputs/form_inputs.dart';
import 'package:test/test.dart';

void main() {
  const passwordString = 'T0pS3cr3t123@';
  group('Password', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const password = Password.pure();
        expect(password.value, '');
        expect(password.pure, true);
      });

      test('dirty creates correct instance', () {
        const password = Password.dirty(passwordString);
        expect(password.value, passwordString);
        expect(password.pure, false);
      });
    });

    group('validator', () {
      test('returns invalid error when password is empty', () {
        expect(
          const Password.dirty().error,
          PasswordValidationError.invalid,
        );
      });

      test('is valid when password is not empty', () {
        expect(
          const Password.dirty(passwordString).error,
          isNull,
        );
      });
    });
  });
}
