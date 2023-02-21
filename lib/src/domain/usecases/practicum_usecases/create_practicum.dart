import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/domain/repositories/practicum_repository.dart';
import 'package:dartz/dartz.dart';

class CreatePracticum {
  final PracticumRepository repository;

  CreatePracticum({required this.repository});

  Future<Either<Failure, bool>> execute(
      {required PracticumEntity practicumEntity}) {
    return repository.create(practicumEntity: practicumEntity);
  }
}
