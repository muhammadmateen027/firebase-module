import 'package:form_inputs/form_inputs.dart';
import 'package:test/test.dart';

void main() {
  const emailString = 'test@gmail.com';
  group('Email', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const email = Email.pure();
        expect(email.value, '');
        expect(email.pure, true);
      });

      test('dirty creates correct instance', () {
        const email = Email.dirty(emailString);
        expect(email.value, emailString);
        expect(email.pure, false);
      });
    });

    group('validator', () {
      test('returns invalid error when email is empty', () {
        expect(
          const Email.dirty().error,
          EmailValidationError.invalid,
        );
      });

      test('returns invalid error when email is malformed', () {
        expect(
          const Email.dirty('test').error,
          EmailValidationError.invalid,
        );
      });

      test('is valid when email is valid', () {
        expect(
          const Email.dirty(emailString).error,
          isNull,
        );
      });
    });
  });
}
