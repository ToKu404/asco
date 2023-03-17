import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/data/datasources/auth_datasource.dart';
import 'package:asco/src/data/models/auth_models/user_model.dart';
import 'package:asco/src/domain/entities/auth_entities/user_credential_entity.dart';
import 'package:asco/src/domain/entities/auth_entities/user_entity.dart';
import 'package:asco/src/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource datasource;

  AuthRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, bool>> createUser({
    required UserEntity userEntity,
  }) async {
    try {
      final result = await datasource.createUser(
        userModel: UserModel.fromEntity(userEntity),
      );

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure('failed to create data'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUser({required String username}) async {
    try {
      final result = await datasource.deleteUser(username: username);

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure('failed to delete data'));
    }
  }

  @override
  Future<Either<Failure, UserCredentialEntity>> logIn({
    required String username,
    required String password,
  }) async {
    try {
      final result = await datasource.logIn(
        username: username,
        password: password,
      );

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure('login failed'));
    }
  }

  @override
  Future<Either<Failure, bool>> logOut() async {
    try {
      final result = await datasource.logOut();

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure('logout failed'));
    }
  }

  @override
  Future<Either<Failure, UserCredentialEntity?>> getUserCredential() async {
    try {
      final result = await datasource.getUserCredential();

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure('failed to get credential'));
    }
  }
}
