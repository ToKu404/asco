import 'package:asco/src/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';

abstract class ClassroomRepository {
  Future<Either<Failure, bool>> create({
    required ClassroomEntity classroom,
    required PracticumEntity? practicum,
  });

  Future<Either<Failure, ClassroomEntity>> single({required String uid});

  Future<Either<Failure, List<ClassroomEntity>>> find({String? practicumUid});

  Future<Either<Failure, bool>> updateStudent({
    required String classroomUid,
    required List<ProfileEntity> students,
  });
}
