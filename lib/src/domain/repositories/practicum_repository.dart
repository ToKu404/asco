import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/practicum_entities/practicum_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';

abstract class PracticumRepository {
  Future<Either<Failure, bool>> create({
    required PracticumEntity practicumEntity,
  });

  Future<Either<Failure, PracticumEntity>> single({required String uid});

  Future<Either<Failure, List<PracticumEntity>>> find({String? query});

  Future<Either<Failure, bool>> updateAssistants({
    required String practicumUid,
    required List<ProfileEntity> assistants,
  });
}
