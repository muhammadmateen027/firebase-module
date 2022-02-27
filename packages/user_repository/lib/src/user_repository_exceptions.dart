/// {@template user_exception}
/// Exceptions from the User profile repository
/// {@endtemplate}
abstract class UserException implements Exception {
  /// {@macro user_exception}
  const UserException(this.error, this.stackTrace);

  /// The error which was caught.
  final Object error;

  /// The stack trace associated with the [error].
  final StackTrace? stackTrace;
}

/// {@template load_user_profile_failure}
/// Thrown during the loading user profile info process if a failure occurs.
/// {@endtemplate}
class LoadProfileFailure extends UserException {
  /// {@macro load_user_profile_failure}
  const LoadProfileFailure(Object error, StackTrace? stackTrace)
      : super(error, stackTrace);
}


/// {@template update_profile_picture_failure}
/// Thrown during the profile picture update process if a failure occurs.
/// {@endtemplate}
class UpdateProfilePictureFailure extends UserException {
  /// {@macro load_user_profile_failure}
  const UpdateProfilePictureFailure(Object error, StackTrace? stackTrace)
      : super(error, stackTrace);
}

/// {@template upload_profile_picture_failure}
/// Thrown during the uploading profile picture process if a failure occurs.
/// {@endtemplate}
class UploadProfilePictureFailure extends UserException {
  /// {@macro upload_profile_picture_failure}
  const UploadProfilePictureFailure(Object error, StackTrace? stackTrace)
      : super(error, stackTrace);
}

/// {@template update_Image_url__failure}
/// Thrown during updaing image url process if a failure occurs.
/// {@endtemplate}
class UpdateImageUrlFailure extends UserException {
  /// {@macro update_Image_url__failure}
  const UpdateImageUrlFailure(Object error, StackTrace? stackTrace)
      : super(error, stackTrace);
}
