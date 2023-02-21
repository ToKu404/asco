import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/domain/repositories/practicum_repository.dart';
import 'package:dartz/dartz.dart';

class GetSinglePracticum {
  final PracticumRepository repository;

  GetSinglePracticum({required this.repository});

  Future<Either<Failure, PracticumEntity>> execute({required String uid}) {
    return repository.single(uid: uid);
  }
}
