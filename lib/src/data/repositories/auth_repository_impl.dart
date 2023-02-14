import 'package:asco/src/data/datasources/auth_datasources.dart';
import 'package:asco/src/data/models/auth_models/user_model.dart';
import 'package:asco/src/domain/entities/auth_entities/user_credential.dart';
import 'package:asco/src/domain/entities/auth_entities/user_entity.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSources authDataSources;

  AuthRepositoryImpl({required this.authDataSources});

  @override
  Future<Either<Failure, bool>> createUser(
      {required UserEntity userEntity}) async {
    try {
      final result = await authDataSources.createUser(
          userModel: UserModel.fromEntity(userEntity));
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, UserCredentialEntity>> logIn(
      {required String username, required String password}) async {
    try {
      final result =
          await authDataSources.logIn(password: password, username: username);
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, UserCredentialEntity?>> getUserCredential() async {
    try {
      final result = await authDataSources.getUserCredential();
      return Right(result);
    } catch (e) {
      return Left(PreferencesFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logOut() async {
    try {
      final result = await authDataSources.logOut();
      return Right(result);
    } catch (e) {
      return Left(PreferencesFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUser({required String username}) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }
}
