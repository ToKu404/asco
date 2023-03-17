import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';

abstract class ClassroomRepository {
  Future<Either<Failure, bool>> create({
    required ClassroomEntity classroom,
    required String practicumUid,
  });

  Future<Either<Failure, ClassroomEntity>> single({required String uid});

  Future<Either<Failure, List<ClassroomEntity>>> find({String? practicumUid});

  Future<Either<Failure, bool>> updateStudent({
    required String classroomUid,
    required List<ProfileEntity> students,
  });
}
