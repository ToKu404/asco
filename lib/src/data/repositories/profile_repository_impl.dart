import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/data/datasources/profile_datasources.dart';
import 'package:asco/src/domain/entities/profile_entities/user_profile_entity.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource authDataSources;

  ProfileRepositoryImpl({required this.authDataSources});

  @override
  Future<Either<Failure, bool>> create(
      {required UserProfileEntity userProfileEntity}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<UserProfileEntity>>> find() {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> remove({required String id}) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserProfileEntity>> single(
      {required String username}) {
    // TODO: implement single
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> update(
      {required UserProfileEntity userProfileEntity, required String id}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
