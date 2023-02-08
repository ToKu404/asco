import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class FirestoreFailure extends Failure {
  const FirestoreFailure(super.message);
}

class PreferencesFailure extends Failure {
  const PreferencesFailure(super.message);
}
