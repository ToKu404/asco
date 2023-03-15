import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';

abstract class AssistanceGroupRepository {
  Future<Either<Failure, bool>> create({
    required AssistanceGroupEntity assistanceGroup,
  });

  Future<Either<Failure, AssistanceGroupEntity>> single({
    required String uuid,
    String? assistant,
  });

  Future<Either<Failure, List<AssistanceGroupEntity>>> find({
    required String practicumUid,
  });

  Future<Either<Failure, bool>> updateStudents({
    required String assistantGroupUid,
    required List<ProfileEntity> students,
  });
}
