import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_service/firebase_storage_service.dart';

/// Use to store files on Firebase storage
class FirebaseStorageService implements StorageService {
  ///storage constructor
  FirebaseStorageService({
    FirebaseAuth? firebaseAuth,
    FirebaseStorage? firebaseStorage,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  /// firebase authentication to get the current user details
  final FirebaseAuth _firebaseAuth;
  final FirebaseStorage _firebaseStorage;

  @override
  Future<void> uploadFile(File file, String storagePath) async {
    try {
      final storageRef = _firebaseStorage.ref().child(storagePath);
      final metadata = SettableMetadata(
        contentType: 'image/${file.path.split('.').last}',
        customMetadata: {'picked-file-path': file.path},
      );
      await storageRef.putFile(file, metadata);
    } catch (error, stackTrace) {
      throw UploadFailure(error, stackTrace);
    }
  }

  @override
  Future<String> downloadURL(String storagePath) async {
    try {
      final url = await _firebaseStorage.ref(storagePath).getDownloadURL();
      return url;
    } catch (error, stackTrace) {
      throw UploadFailure(error, stackTrace);
    }
  }

  @override
  Future<String> getUrlFromFile(
    File file, {
    String directory = 'posts',
  }) async {
    final path = file.path;
    final uniquePath = '${DateTime.now().millisecondsSinceEpoch}'
        '${Random().nextInt(1000)}';
    final extension = '$uniquePath.${path.split('.').last}';
    final storagePath =
        '/$directory/${_firebaseAuth.currentUser!.uid}/$extension';

    final storageReference = _firebaseStorage.ref().child(storagePath);
    final metadata = SettableMetadata(
      contentType: 'image/${path.split('.').last}',
      customMetadata: {'picked-file-path': path},
    );
    await storageReference.putFile(file, metadata);

    return storageReference.getDownloadURL();
  }
}
