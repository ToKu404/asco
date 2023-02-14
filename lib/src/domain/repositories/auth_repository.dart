import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/auth_entities/user_credential.dart';
import 'package:asco/src/domain/entities/auth_entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> createUser({required UserEntity userEntity});
  Future<Either<Failure, UserCredentialEntity>> logIn(
      {required String username, required String password});
  Future<Either<Failure, UserCredentialEntity?>> getUserCredential();
  Future<Either<Failure, bool>> deleteUser({required String username});
  Future<Either<Failure, bool>> logOut();
}
