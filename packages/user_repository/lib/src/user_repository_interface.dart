part of 'user_repository.dart';

/// This repository interface will be used for communication and expose
/// public methods
abstract class UserRepositoryInterface {
  /// Load user personal information
  Future<UserPersonalInfo> getProfileInfo([String profileId = '']);

  /// Updates the user's profile picture. Return's it's new link
  Future<String> updateProfilePicture(String path);

  /// Updates the user's cover picture. Returns it's new link
  Future<String> updateCoverPicture(String path);

  /// Check if username exists and is registered, then load list
  Future<QuerySnapshot> searchUsers(String username);

  /// To update user's basic info
  Future<void> updateProfile(Map<String, Object> userInfo);

  /// Function will be used to check either following or not
  Future<bool> isFollowerOf(String followedUserId, String followerUserId);

  /// Add [userToFollow] to [follower]'s following collection,
  /// and add [follower] to [userToFollow]'s followers collection
  Future<void> addFollowerTo(
    FollowerInfo userToFollow,
    FollowerInfo follower,
  );

  /// Remove [userToUnfollow] from [follower]'s following collection,
  /// and remove [follower] from [userToUnfollow]'s followers collection
  Future<void> removeFollowerTo(String userToUnfollow, String follower);

  /// Returns a list of FollowersInfo related to [userId]
  /// If followersOf == true, return followers, else returns following
  Future<List<FollowerInfo>> loadInitialFollowers({
    required String userId,
    required bool followersOf,
  });

  /// Returns more followers of [userId]
  /// If followersOf == true, return followers, else returns following
  Future<List<FollowerInfo>> loadMoreFollowers({
    required String userId,
    required bool followersOf,
  });

  /// Returns all followers of [userId]
  Future<List<FollowerInfo>> loadAllFollowers({
    required String userId,
  });

  /// Use to report any type of content
  Future<void> reportContent(Report report);

  /// Load all reports
  Future<List<Report>> getReports();

  /// Delete user data
  Future<void> removeUserHistory([String? userId]);
}
