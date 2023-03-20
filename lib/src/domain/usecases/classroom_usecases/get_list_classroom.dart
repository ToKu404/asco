import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
import 'package:asco/src/domain/repositories/classroom_repository.dart';

class GetListClassroom {
  final ClassroomRepository repository;

  GetListClassroom({required this.repository});

  Future<Either<Failure, List<ClassroomEntity>>> execute({
    String? practicumUid,
  }) {
    return repository.find(practicumUid: practicumUid);
  }
}
