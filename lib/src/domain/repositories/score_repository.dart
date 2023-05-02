import 'package:asco/src/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';

abstract class ScoreRepository {
  Future<Either<Failure, List<ScoreEntity>>> multiple({
    required List<String> multipleId,
  });

  Future<Either<Failure, bool>> update({
    required ScoreEntity newScore,
    required String uid,
  });
}
