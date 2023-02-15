import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/auth_entities/user_credential.dart';
import 'package:asco/src/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetUser {
  final AuthRepository authRepository;
  GetUser({required this.authRepository});

  Future<Either<Failure, UserCredentialEntity?>> execute() {
    return authRepository.getUserCredential();
  }
}
