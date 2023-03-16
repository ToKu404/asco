import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/auth_entities/user_credential_entity.dart';
import 'package:asco/src/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetUser {
  final AuthRepository repository;
  GetUser({required this.repository});

  Future<Either<Failure, UserCredentialEntity?>> execute() {
    return repository.getUserCredential();
  }
}
