import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/auth_entities/user_credential.dart';
import 'package:asco/src/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class Login {
  final AuthRepository authRepository;

  Login({required this.authRepository});

  Future<Either<Failure, UserCredentialEntity>> execute({
    required String username,
    required String password,
  }) {
    return authRepository.logIn(username: username, password: password);
  }
}
