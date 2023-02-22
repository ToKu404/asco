import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/data/datasources/profile_datasources.dart';
import 'package:asco/src/data/models/profile_models/detail_profile_model.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource datasource;

  ProfileRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, bool>> create(
      {required DetailProfileEntity userProfileEntity}) async {
    try {
      final result = await datasource.create(
          userProfileModel: DetailProfileModel.fromEntity(userProfileEntity));
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<DetailProfileEntity>>> find({
    String? query,
    int? byRole,
  }) async {
    try {
      final result = await datasource.find(
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
      final result = await datasource.remove(uid: uid);
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, DetailProfileEntity>> single(
      {required String uid}) async {
    try {
      final result = await datasource.single(uid: uid);
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, bool>> update(
      {required DetailProfileEntity userProfileEntity}) async {
    try {
      final result = await datasource.update(
        userProfileModel: DetailProfileModel.fromEntity(userProfileEntity),
      );
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, DetailProfileEntity>> me() async {
    try {
      final result = await datasource.me();
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }
}
