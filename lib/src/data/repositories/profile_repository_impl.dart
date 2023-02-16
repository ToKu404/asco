import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/data/datasources/profile_datasources.dart';
import 'package:asco/src/data/models/profile_models/user_profile_model.dart';
import 'package:asco/src/domain/entities/profile_entities/user_profile_entity.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource profileDataSources;

  ProfileRepositoryImpl({required this.profileDataSources});

  @override
  Future<Either<Failure, bool>> create(
      {required UserProfileEntity userProfileEntity}) async {
    try {
      final result = await profileDataSources.create(
          userProfileModel: UserProfileModel.fromEntity(userProfileEntity));
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<UserProfileEntity>>> find({
    String? query,
    int? byRole,
  }) async {
    try {
      final result = await profileDataSources.find(
        query: query,
        byRole: byRole,
      );

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, bool>> remove({required String uid}) async {
    try {
      final result = await profileDataSources.remove(uid: uid);
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, UserProfileEntity>> single(
      {required String uid}) async {
    try {
      final result = await profileDataSources.single(uid: uid);
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, bool>> update(
      {required UserProfileEntity userProfileEntity}) async {
    try {
      final result = await profileDataSources.update(
        userProfileModel: UserProfileModel.fromEntity(userProfileEntity),
      );
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, UserProfileEntity>> me() async {
    try {
      final result = await profileDataSources.me();
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }
}
