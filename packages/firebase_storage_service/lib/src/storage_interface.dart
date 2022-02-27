import 'dart:io';

/// Use to communicate with remote storage.
abstract class StorageService {
  /// Uploads a file to remote storage
  Future<void> uploadFile(File file, String storagePath);

  /// Returns the URL of the file stored in [storagePath]
  Future<String> downloadURL(String storagePath);

  /// Returns the URL of the file stored in [storage Path]
  Future<String> getUrlFromFile(File file);
}
