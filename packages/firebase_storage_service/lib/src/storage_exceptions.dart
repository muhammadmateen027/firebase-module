/// {@template storage_exception}
/// Exceptions from the Storage service
/// {@endtemplate}
abstract class StorageException implements Exception {
  /// {@macro storage_exception}
  const StorageException(this.error, this.stackTrace);

  /// The error which was caught.
  final Object error;

  /// The stack trace associated with the [error].
  final StackTrace? stackTrace;
}

/// {@template upload_failure}
/// Thrown during the upload process if a failure occurs.
/// {@endtemplate}
class UploadFailure extends StorageException {
  /// {@macro upload_failure}
  const UploadFailure(Object error, StackTrace? stackTrace)
      : super(error, stackTrace);
}

/// {@template upload_failure}
/// Thrown during the downloadUrl process if a failure occurs.
/// {@endtemplate}
class DownloadURLFailure extends StorageException {
  /// {@macro download_url_failure}
  const DownloadURLFailure(Object error, StackTrace? stackTrace)
      : super(error, stackTrace);
}
