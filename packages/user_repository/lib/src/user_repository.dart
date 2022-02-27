import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage_service/firebase_storage_service.dart';
import 'package:user_repository/user_repository.dart';

part 'user_repository_interface.dart';

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
  final userCollection = FirebaseFirestore.instance.collection('users');

  /// this method will throw errors if something is not available
  /// otherwise will provide user information
  @override
  Future<UserPersonalInfo> getProfileInfo([String? profileId]) async {
    try {
      final currentUser = _firebaseAuth.currentUser;

      profileId = profileId ?? currentUser?.uid;

      final snapshotDocument = await userCollection.doc(profileId).get();

      final userData = snapshotDocument.data()!
        ..addAll(<String, String>{
          'id': snapshotDocument.id,
          'email': currentUser?.email ?? '',
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
  Future<void> updateProfile(Map<String, Object> userInfo) async {
    try {
      return userCollection
          .doc(_firebaseAuth.currentUser!.uid)
          .update(userInfo);
    } catch (error, stacktrace) {
      throw LoadProfileFailure(error, stacktrace);
    }
  }
}
