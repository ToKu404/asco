import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/data/datasources/practicum_datasource.dart';
import 'package:asco/src/data/models/practicum_models/practicum_model.dart';
import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/domain/repositories/practicum_repository.dart';

class PracticumRepositoryImpl implements PracticumRepository {
  final PracticumDataSource datasource;

  PracticumRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, bool>> create({
    required PracticumEntity practicumEntity,
  }) async {
    try {
      final result = await datasource.create(
        practicum: PracticumModel.fromEntity(practicumEntity),
      );

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure('failed to create data'));
    }
  }

  @override
  Future<Either<Failure, PracticumEntity>> single({required String uid}) async {
    try {
      final result = await datasource.single(uid: uid);

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure('failed to get data'));
    }
  }

  @override
  Future<Either<Failure, List<PracticumEntity>>> find({String? query}) async {
    try {
      final result = await datasource.find(query: query);

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure('failed to find data'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateAssistants({
    required String practicumUid,
    required List<ProfileEntity> assistants,
  }) async {
    try {
      final result = await datasource.updateAssistants(
        practicumUid: practicumUid,
        assistants: assistants,
      );

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure('failed to update data'));
    }
  }
}
