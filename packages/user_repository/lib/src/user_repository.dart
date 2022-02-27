import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage_service/firebase_storage_service.dart';
import 'package:user_repository/user_repository.dart';

part 'user_repository_interface.dart';

const _reportPostsCollection = 'Reports';
const _usersCollection = 'users';
const _followingCollection = 'Following';
const _followersCollection = 'Followers';

/// Repository for everything related to user information
class UserRepository implements UserRepositoryInterface {
  /// {@macro user_repository}
  UserRepository({
    FirebaseAuth? firebaseAuth,
    StorageService? storageService,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _storageService = storageService ?? FirebaseStorageService();

  final FirebaseAuth _firebaseAuth;
  final StorageService _storageService;

  /// get user collection instance to perform CRUD operations
  final userCollection =
      FirebaseFirestore.instance.collection(_usersCollection);

  /// this method will throw errors if something is not available
  /// otherwise will provide user information
  @override
  Future<UserPersonalInfo> getProfileInfo([String? profileId]) async {
    try {
      final currentUser = _firebaseAuth.currentUser;

      if (currentUser == null) {
        throw const LoadProfileFailure('', StackTrace.empty);
      }

      profileId = profileId ?? currentUser.uid;

      final snapshotDocument = await userCollection.doc(profileId).get();

      final userData = snapshotDocument.data()!
        ..addAll(<String, String>{
          'id': snapshotDocument.id,
          'phoneNumber': currentUser.phoneNumber ?? '',
          'email': currentUser.email ?? '',
        });

      return UserPersonalInfo.fromJson(userData);
    } catch (error, stacktrace) {
      throw LoadProfileFailure(error, stacktrace);
    }
  }

  @override
  Future<String> updateProfilePicture(String path) async {
    try {
      final user = _firebaseAuth.currentUser;
      final storagePath = await _uploadProfilePicture(path, user);
      return _updateUserProfilePictureURL(storagePath, user);
    } catch (error, stackTrace) {
      throw UpdateProfilePictureFailure(error, stackTrace);
    }
  }

  Future<String> _uploadProfilePicture(String path, User? user) async {
    final extension = path.split('.').last;
    final storagePath = '/users/${user?.uid}.$extension';
    final file = File(path);
    await _storageService.uploadFile(file, storagePath);
    return storagePath;
  }

  Future<String> _updateUserProfilePictureURL(String path, User? user) async {
    final imageURL = await _storageService.downloadURL(path);
    final snapshotDocument = userCollection.doc(user?.uid);
    final data = {'profile_picture': imageURL};
    await snapshotDocument.update(data);
    return imageURL;
  }

  @override
  Future<String> updateCoverPicture(String path) async {
    try {
      final user = _firebaseAuth.currentUser;
      final storagePath = await _uploadCoverPicture(path, user);
      return _updateUserCoverPictureURL(storagePath, user);
    } catch (error, stackTrace) {
      throw UpdateProfilePictureFailure(error, stackTrace);
    }
  }

  Future<String> _uploadCoverPicture(String path, User? user) async {
    final extension = path.split('.').last;
    final storagePath = '/users/banners/${user?.uid}.$extension';
    final file = File(path);
    await _storageService.uploadFile(file, storagePath);
    return storagePath;
  }

  Future<String> _updateUserCoverPictureURL(String path, User? user) async {
    final imageURL = await _storageService.downloadURL(path);
    final snapshotDocument = userCollection.doc(user?.uid);
    final data = {'banner': imageURL};
    await snapshotDocument.update(data);
    return imageURL;
  }

  /// Check if username exists and registered
  ///
  @override
  Future<QuerySnapshot> searchUsers(String handle) async {
    try {
      // Fetch sign-in methods for the email address
      final snapshotDocument = await userCollection
          .where(
            'handle',
            isGreaterThanOrEqualTo: handle,
          )
          .get();
      return snapshotDocument;
    } catch (error, stackTrace) {
      throw LoadProfileFailure(error, stackTrace);
    }
  }

  @override
  Future<void> updateProfile(Map<String, Object> userInfo) async {
    try {
      return userCollection
          .doc(_firebaseAuth.currentUser!.uid)
          .update(userInfo);
    } catch (error, stacktrace) {
      throw LoadProfileFailure(error, stacktrace);
    }
  }

  @override
  Future<bool> isFollowerOf(
    String followedId,
    String followerId,
  ) async {
    try {
      final snapshotDocument = await userCollection
          .doc(followedId)
          .collection(_followersCollection)
          .where('id', isEqualTo: followerId)
          .get();

      return snapshotDocument.size > 0;
    } catch (error, stackTrace) {
      throw UserFollowingStatusFailure(error, stackTrace);
    }
  }

  @override
  Future<void> addFollowerTo(
    FollowerInfo userToFollow,
    FollowerInfo follower,
  ) async {
    try {
      if (await isFollowerOf(userToFollow.id!, follower.id!)) {
        return;
      }

      final userToFollowJson = userToFollow.toJson();
      final followerJson = follower.toJson();

      final userToFollowDoc = userCollection.doc(userToFollow.id);

      final followerDoc = userCollection.doc(follower.id);

      final docs = await Future.wait([
        userToFollowDoc.get(),
        followerDoc.get(),
      ]);

      final userToFollowFollowersCount =
          docs[0].data()!['followerCount'] as int? ?? 0;

      final followerFollowingCount =
          docs[1].data()!['followingCount'] as int? ?? 0;

      await Future.wait([
        userToFollowDoc
            .collection(_followersCollection)
            .doc(follower.id)
            .set(followerJson),
        followerDoc
            .collection(_followingCollection)
            .doc(userToFollow.id)
            .set(userToFollowJson),
        userToFollowDoc.set(
          <String, dynamic>{'followerCount': userToFollowFollowersCount + 1},
          SetOptions(merge: true),
        ),
        followerDoc.set(
          <String, dynamic>{'followingCount': followerFollowingCount + 1},
          SetOptions(merge: true),
        ),
      ]);

      return;
    } catch (error, stackTrace) {
      throw UserFollowingFailure(error, stackTrace);
    }
  }

  @override
  Future<void> removeFollowerTo(
    String userIdToUnfollow,
    String followerId,
  ) async {
    try {
      if (!await isFollowerOf(userIdToUnfollow, followerId)) {
        return;
      }

      final userToUnfollowDoc = userCollection.doc(userIdToUnfollow);

      final followerDoc = userCollection.doc(followerId);

      final docs = await Future.wait([
        userToUnfollowDoc.get(),
        followerDoc.get(),
      ]);

      final userToFollowFollowersCount =
          docs[0].data()!['followerCount'] as int? ?? 0;

      final followerFollowingCount =
          docs[1].data()!['followingCount'] as int? ?? 0;

      await Future.wait([
        userToUnfollowDoc
            .collection(_followersCollection)
            .doc(followerId)
            .delete(),
        followerDoc
            .collection(_followingCollection)
            .doc(userIdToUnfollow)
            .delete(),
        userToUnfollowDoc.set(
          <String, dynamic>{'followerCount': userToFollowFollowersCount - 1},
          SetOptions(merge: true),
        ),
        followerDoc.set(
          <String, dynamic>{'followingCount': followerFollowingCount - 1},
          SetOptions(merge: true),
        ),
      ]);

      return;
    } catch (error, stackTrace) {
      throw UserUnFollowingFailure(error, stackTrace);
    }
  }

  /// When loading more followers, load this amount
  final int followerLoadingLimit = 15;

  DocumentSnapshot? _lastFollowerDoc;

  FollowerInfo _fromDocToFollower(DocumentSnapshot<Map<String, dynamic>> doc) {
    final userData = doc.data()!
      ..addAll(<String, String>{
        'id': doc.id,
      });
    return FollowerInfo.fromJson(userData);
  }

  @override
  Future<List<FollowerInfo>> loadInitialFollowers({
    required String userId,
    required bool followersOf,
  }) async {
    final collection =
        followersOf ? _followersCollection : _followingCollection;

    try {
      final snapshotDocument = await userCollection
          .doc(userId)
          .collection(collection)
          .limit(followerLoadingLimit)
          .get();

      if (snapshotDocument.docs.isEmpty) return [];

      _lastFollowerDoc = snapshotDocument.docs.last;

      final followerList = snapshotDocument.docs.map(_fromDocToFollower);

      return followerList.toList();
    } catch (error, stackTrace) {
      throw LoadFollowersFailure(error, stackTrace);
    }
  }

  @override
  Future<List<FollowerInfo>> loadMoreFollowers({
    required String userId,
    required bool followersOf,
  }) async {
    if (_lastFollowerDoc == null) return [];

    final collection =
        followersOf ? _followersCollection : _followingCollection;

    final snapshotDocument = await userCollection
        .doc(userId)
        .collection(collection)
        .startAfterDocument(_lastFollowerDoc!)
        .limit(followerLoadingLimit)
        .get();

    if (snapshotDocument.docs.isEmpty) return [];

    _lastFollowerDoc = snapshotDocument.docs.last;

    return snapshotDocument.docs.map(_fromDocToFollower) as List<FollowerInfo>;
  }

  @override
  Future<List<FollowerInfo>> loadAllFollowers({
    required String userId,
  }) async {
    try {
      final snapshotDocument = await userCollection
          .doc(userId)
          .collection(_followingCollection)
          .get();

      if (snapshotDocument.docs.isEmpty) return [];

      _lastFollowerDoc = snapshotDocument.docs.last;

      final followerList = snapshotDocument.docs.map(_fromDocToFollower);

      return followerList.toList();
    } catch (error, stackTrace) {
      throw LoadFollowersFailure(error, stackTrace);
    }
  }

  @override
  Future<void> reportContent(Report report) async {
    try {
      if (report.type == ReportType.unset) {
        throw const ReportsFailure(
          'Tried to report with report type unset',
          null,
        );
      }

      await userCollection
          .doc(_firebaseAuth.currentUser!.uid)
          .collection(_reportPostsCollection)
          .add(report.toJson());
    } catch (error, stacktrace) {
      throw ReportsFailure(error, stacktrace);
    }
  }

  @override
  Future<List<Report>> getReports() async {
    try {
      final querySnapshot = await userCollection
          .doc(_firebaseAuth.currentUser!.uid)
          .collection(_reportPostsCollection)
          .get();

      final reports = querySnapshot.docs
          .map((reportSnapshot) => Report.fromJson(reportSnapshot.data()))
          .toList();

      return reports;
    } catch (error, stacktrace) {
      throw ReportsFailure(error, stacktrace);
    }
  }

  @override
  Future<void> removeUserHistory([String? userId]) async {
    try {
      final currentUser = _firebaseAuth.currentUser!.uid;
      final document = await userCollection.doc(userId ?? currentUser).get();
      await document.reference.delete();
    } catch (error, stacktrace) {
      throw UserHistoryRemovalFailure(error, stacktrace);
    }
  }
}
