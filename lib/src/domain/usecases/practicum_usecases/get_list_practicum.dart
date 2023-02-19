import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/domain/repositories/practicum_repository.dart';
import 'package:dartz/dartz.dart';

class GetListPracticum {
  final PracticumRepository practicumRepository;

  GetListPracticum({required this.practicumRepository});

  Future<Either<Failure, List<PracticumEntity>>> execute({
    String? query,
  }) {
    return practicumRepository.find(
      query: query,
    );
  }
}
