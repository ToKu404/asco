/// Exception class that will be thrown when there is a problem
/// related to the firestore.
class FirestoreException implements Exception {
  final String message;

  FirestoreException(this.message);
}

/// Exception class that will be thrown when there is a problem
/// related to the reference.
class ReferenceException implements Exception {
  final String message;

  ReferenceException(this.message);
}
