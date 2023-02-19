import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/data/datasources/practicum_datasources.dart';
import 'package:asco/src/data/models/practicum_models/practicum_model.dart';
import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/domain/repositories/practicum_repository.dart';
import 'package:dartz/dartz.dart';

class PracticumRepositoryImpl implements PracticumRepository {
  final PracticumDataSource practicumDataSource;

  PracticumRepositoryImpl({required this.practicumDataSource});

  @override
  Future<Either<Failure, bool>> create(
      {required PracticumEntity practicumEntity}) async {
    try {
      final result = await practicumDataSource.create(
          practicum: PracticumModel.fromEntity(practicumEntity));
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<PracticumEntity>>> find({
    String? query,
  }) async {
    try {
      final result = await practicumDataSource.find(
        query: query,
      );

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, PracticumEntity>> single({required String uid}) async {
    try {
      final result = await practicumDataSource.single(uid: uid);
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }
}
