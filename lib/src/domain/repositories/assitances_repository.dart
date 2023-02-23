import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AssistancesGroupRepository {
  Future<Either<Failure, bool>> create({
    required AssistanceGroupEntity entity,
  });
  Future<Either<Failure, AssistanceGroupEntity>> single(
      {required String uuid, String? assistant});
  Future<Either<Failure, List<AssistanceGroupEntity>>> find({
    required String practicumUid,
  });
  Future<Either<Failure, bool>> updateStudent({
    required String assistantGroupUid,
    required List<ProfileEntity> students,
  });
}
