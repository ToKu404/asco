import 'package:asco/src/domain/entities/entities.dart';
import 'package:asco/src/domain/repositories/score_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';

class UpdateScore {
  final ScoreRepository repository;

  UpdateScore({required this.repository});

  Future<Either<Failure, bool>> execute({
    required String uid,
    required ScoreEntity newScore,
  }) {
    return repository.update(
      uid: uid,
      newScore: newScore,
    );
  }
}
