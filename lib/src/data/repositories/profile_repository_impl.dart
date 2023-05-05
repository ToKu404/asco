import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/exception.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/data/datasources/profile_datasource.dart';
import 'package:asco/src/data/models/profile_models/detail_profile_model.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/user_practicum_helper.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource datasource;

  ProfileRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, bool>> create({
    required DetailProfileEntity userProfileEntity,
  }) async {
    try {
      final result = await datasource.create(
        userProfileModel: DetailProfileModel.fromEntity(userProfileEntity),
      );

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed to create data'));
    }
  }

  @override
  Future<Either<Failure, bool>> update({
    required DetailProfileEntity userProfileEntity,
  }) async {
    try {
      final result = await datasource.update(
        userProfileModel: DetailProfileModel.fromEntity(userProfileEntity),
      );

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed to update data'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateMultiplePracticums({
    required Map<String, Map<String, UserPracticumHelper>> data,
  }) async {
    try {
      final result = await datasource.updateMultiplePracticums(data: data);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed to update multiple data'));
    }
  }

  @override
  Future<Either<Failure, bool>> remove({required String uid}) async {
    try {
      final result = await datasource.remove(uid: uid);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed to delete data'));
    }
  }

  @override
  Future<Either<Failure, DetailProfileEntity>> self() async {
    try {
      final result = await datasource.self();

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed to get data'));
    } on PreferenceException {
      return const Left(PreferenceFailure('failed to get data'));
    }
  }

  @override
  Future<Either<Failure, DetailProfileEntity>> single({
    required String uid,
  }) async {
    try {
      final result = await datasource.single(uid: uid);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed to get data'));
    }
  }

  @override
  Future<Either<Failure, List<DetailProfileEntity>>> multiple({
    required List<String> multipleId,
  }) async {
    try {
      final result = await datasource.multiple(multipleId: multipleId);
      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed to get multiple data'));
    }
  }

  @override
  Future<Either<Failure, List<DetailProfileEntity>>> find({
    String? query,
    int? roleId,
    String? practicumUid,
  }) async {
    try {
      final result = await datasource.find(
        query: query,
        roleId: roleId,
        practicumUid: practicumUid,
      );

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed to find data'));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(
    String path,
    String uid,
    String filename,
  ) async {
    try {
      final result = await datasource.uploadProfilePicture(path, uid, filename);

      return Right(result);
    } on StorageException {
      return const Left(StorageFailure('failed to upload file'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProfilePicture(
    String uid,
    String filename,
  ) async {
    try {
      final result = await datasource.deleteProfilePicture(uid, filename);

      return Right(result);
    } on StorageException {
      return const Left(StorageFailure('failed to delete file'));
    }
  }
}
