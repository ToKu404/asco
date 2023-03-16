import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/auth_entities/user_credential_entity.dart';
import 'package:asco/src/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class Login {
  final AuthRepository repository;

  Login({required this.repository});

  Future<Either<Failure, UserCredentialEntity>> execute({
    required String username,
    required String password,
  }) {
    return repository.logIn(username: username, password: password);
  }
}
