import 'package:equatable/equatable.dart';

/// A base Failure class.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// A class that will be returned when a **Firestore Failure** occurs.
class FirestoreFailure extends Failure {
  const FirestoreFailure(super.message);
}

/// A class that will be returned when a **Preference Failure** occurs.
class PreferenceFailure extends Failure {
  const PreferenceFailure(super.message);
}

/// A class that will be returned when a **Storage Failure** occurs.
class StorageFailure extends Failure {
  const StorageFailure(String message) : super(message);
}
