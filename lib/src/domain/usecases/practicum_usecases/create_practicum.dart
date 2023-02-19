import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/domain/repositories/practicum_repository.dart';
import 'package:dartz/dartz.dart';

class CreatePracticum {
  final PracticumRepository practicumRepository;

  CreatePracticum({required this.practicumRepository});

  Future<Either<Failure, bool>> execute(
      {required PracticumEntity practicumEntity}) {
    return practicumRepository.create(practicumEntity: practicumEntity);
  }
}
