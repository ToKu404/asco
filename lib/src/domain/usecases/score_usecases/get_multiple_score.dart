import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/entities.dart';
import 'package:asco/src/domain/repositories/score_repository.dart';
import 'package:dartz/dartz.dart';

class GetMultipleScore {
  final ScoreRepository repository;

  GetMultipleScore({required this.repository});

  Future<Either<Failure, List<ScoreEntity>>> execute({
    required List<String> listId,
  }) async {
    return await repository.multiple(
      multipleId: listId,
    );
  }
}
