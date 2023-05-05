/// Exception class that will be thrown when there is a problem
/// related to Firestore.
class FirestoreException implements Exception {
  final String message;

  FirestoreException(this.message);
}

/// Exception class that will be thrown when there is a problem
/// related to Shared Preferences.
class PreferenceException implements Exception {
  final String message;

  PreferenceException(this.message);
}

/// Exception class that will be thrown when there is a problem
/// related to the firebase storage.
class StorageException implements Exception {
  final String message;

  StorageException(this.message);
}
