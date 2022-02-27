/// {@template authentication_exception}
/// Exceptions from the authentication repository
/// {@endtemplate}
abstract class AuthenticationException implements Exception {
  /// {@macro authentication_exception}
  const AuthenticationException(this.error, {this.stackTrace, this.code});

  /// The error which was caught.
  final Object error;

  /// The stack trace associated with the [error].
  final StackTrace? stackTrace;

  /// to pass the error code to extract exact error
  final String? code;
}

/// {@template sign_up_failure}
/// Thrown during the sign up process if a failure occurs.
/// {@endtemplate}
class SignUpFailure extends AuthenticationException {
  /// {@macro sign_up_failure}
  const SignUpFailure(Object error, {StackTrace? stackTrace, String? code})
      : super(error, stackTrace: stackTrace, code: code);
}

/// {@template sign_up_failure}
/// Thrown during the sign up process if a failure occurs.
/// {@endtemplate}
class UpdateFailure extends AuthenticationException {
  /// {@macro sign_up_failure}
  const UpdateFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace: stackTrace);
}

/// {@template sign_up_failure}
/// Thrown during the phone sign up process if a failure occurs.
/// {@endtemplate}
class PhoneSignUpFailure extends AuthenticationException {
  /// {@macro sign_up_failure}
  const PhoneSignUpFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace: stackTrace);
}

/// {@template reset_password_failure}
/// Thrown during the password reset process if a failure occurs.
/// {@endtemplate}
class ResetPasswordFailure extends AuthenticationException {
  /// {@macro reset_password_failure}
  const ResetPasswordFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace: stackTrace);
}

/// {@template email_existing_failure}
/// Thrown during the email checking process if a failure occurs.
/// {@endtemplate}
class EmailExistingFailure extends AuthenticationException {
  /// {@macro email_existing_failure}
  const EmailExistingFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace: stackTrace);
}

/// {@template log_in_with_email_and_password_failure}
/// Thrown during the login process if a failure occurs.
/// {@endtemplate}
class LogInWithEmailAndPasswordFailure extends AuthenticationException {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure(Object error,
      {StackTrace? stackTrace, String? code})
      : super(error, stackTrace: stackTrace, code: code);
}

/// {@template log_in_with_apple_failure}
/// Thrown during the sign in with apple process if a failure occurs.
/// {@endtemplate}
class LogInWithAppleFailure extends AuthenticationException {
  /// {@macro log_in_with_apple_failure}
  const LogInWithAppleFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace: stackTrace);
}

/// {@template log_in_with_google_failure}
/// Thrown during the sign in with google process if a failure occurs.
/// {@endtemplate}
class LogInWithGoogleFailure extends AuthenticationException {
  /// {@macro log_in_with_google_failure}
  const LogInWithGoogleFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace: stackTrace);
}

/// {@template log_in_with_phone_number_failure}
/// Thrown during the sign in with phone number process if a failure occurs.
/// {@endtemplate}
class LogInWithPhoneNumberFailure extends AuthenticationException {
  /// {@macro log_in_with_phone_number_failure}
  const LogInWithPhoneNumberFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace: stackTrace);
}

/// {@template log_out_failure}
/// Thrown during the logout process if a failure occurs.
/// {@endtemplate}
class LogOutFailure extends AuthenticationException {
  /// {@macro log_out_failure}
  const LogOutFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace: stackTrace);
}

/// {@template firestore_failure}
/// Thrown during the username verification process if a failure occurs.
/// {@endtemplate}
class FirestoreFailure extends AuthenticationException {
  /// {@macro firestore_failure}
  const FirestoreFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace: stackTrace);
}
