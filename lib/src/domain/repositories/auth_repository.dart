import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/auth_entities/user_credential_entity.dart';
import 'package:asco/src/domain/entities/auth_entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> createUser({required UserEntity userEntity});

  Future<Either<Failure, bool>> deleteUser({required String username});

  Future<Either<Failure, UserCredentialEntity>> logIn({
    required String username,
    required String password,
  });

  Future<Either<Failure, bool>> logOut();

  Future<Either<Failure, UserCredentialEntity?>> getUserCredential();
}
