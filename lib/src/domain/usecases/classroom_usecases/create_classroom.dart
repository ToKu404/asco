import 'package:asco/src/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/repositories/classroom_repository.dart';

class CreateClassroom {
  final ClassroomRepository repository;

  CreateClassroom({required this.repository});

  Future<Either<Failure, bool>> execute({
    required ClassroomEntity classroom,
    required PracticumEntity? practicum,
  }) {
    return repository.create(
      classroom: classroom,
      practicum: practicum,
    );
  }
}
