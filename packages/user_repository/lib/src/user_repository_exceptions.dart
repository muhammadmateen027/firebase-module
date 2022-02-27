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

/// {@template load_followers_failure}
/// Thrown during the loading followers process if a failure occurs.
/// {@endtemplate}
class LoadFollowersFailure extends UserException {
  /// {@macro load_followers_failure}
  const LoadFollowersFailure(Object error, StackTrace? stackTrace)
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

/// {@template user_following_failure}
/// Thrown during the user following process if a failure occurs.
/// {@endtemplate}
class UserFollowingFailure extends UserException {
  /// {@macro load_user_profile_failure}
  const UserFollowingFailure(Object error, StackTrace? stackTrace)
      : super(error, stackTrace);
}

/// {@template user_un_following_failure}
/// Thrown during the user un-following process if a failure occurs.
/// {@endtemplate}
class UserUnFollowingFailure extends UserException {
  /// {@macro load_user_profile_failure}
  const UserUnFollowingFailure(Object error, StackTrace? stackTrace)
      : super(error, stackTrace);
}

/// {@template user_following_status_failure}
/// Thrown during checking the user is following process if a failure occurs.
/// {@endtemplate}
class UserFollowingStatusFailure extends UserException {
  /// {@macro load_user_profile_failure}
  const UserFollowingStatusFailure(Object error, StackTrace? stackTrace)
      : super(error, stackTrace);
}

/// {@template reports_failure}
/// Thrown when an error occurs when interacting with the reports collection.
/// {@endtemplate}
class ReportsFailure extends UserException {
  /// {@macro reports_failure}
  const ReportsFailure(Object error, StackTrace? stackTrace)
      : super(error, stackTrace);
}

/// {@template user_history_removal_failure}
/// Thrown when an error occurs when interacting with the user collection.
/// {@endtemplate}
class UserHistoryRemovalFailure extends UserException {
  /// {@macro user_history_removal_failure}
  const UserHistoryRemovalFailure(Object error, StackTrace? stackTrace)
      : super(error, stackTrace);
}
