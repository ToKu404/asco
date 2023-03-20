import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
import 'package:asco/src/domain/repositories/classroom_repository.dart';

class CreateClassroom {
  final ClassroomRepository repository;

  CreateClassroom({required this.repository});

  Future<Either<Failure, bool>> execute({
    required ClassroomEntity classroom,
    required String practicumUid,
  }) {
    return repository.create(
      classroom: classroom,
      practicumUid: practicumUid,
    );
  }
}
