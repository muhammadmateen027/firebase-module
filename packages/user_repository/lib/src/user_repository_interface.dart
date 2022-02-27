part of 'user_repository.dart';

/// This repository interface will be used for communication and expose
/// public methods
abstract class UserRepositoryInterface {
  /// Load user personal information
  Future<UserPersonalInfo> getProfileInfo([String profileId = '']);

  /// Updates the user's profile picture. Return's it's new link
  Future<String> updateProfilePicture(String path);

  /// To update user's basic info
  Future<void> updateProfile(Map<String, Object> userInfo);
}
