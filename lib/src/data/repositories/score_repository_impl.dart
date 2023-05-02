import 'package:asco/core/utils/exception.dart';
import 'package:asco/src/data/datasources/score_data_source.dart';
import 'package:asco/src/data/models/models.dart';
import 'package:asco/src/domain/entities/score_entities/score_entity.dart';
import 'package:asco/src/domain/repositories/score_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';

class ScoreRepositoryImpl implements ScoreRepository {
  final ScoreDataSource datasource;

  ScoreRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<ScoreEntity>>> multiple(
      {required List<String> multipleId}) async {
    try {
      final result = await datasource.multiple(multipleId: multipleId);
      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed'));
    }
  }

  @override
  Future<Either<Failure, bool>> update(
      {required String uid, required ScoreEntity newScore}) async {
    try {
      final result = await datasource.update(
          uid: uid, score: ScoreModel.fromEntity(newScore));
      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('failed'));
    }
  }
}
