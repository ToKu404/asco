import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
import 'package:asco/src/domain/repositories/classroom_repository.dart';
import 'package:dartz/dartz.dart';

class GetSingleClassroom {
  final ClassroomRepository repository;

  GetSingleClassroom({required this.repository});

  Future<Either<Failure, ClassroomEntity>> execute({required String uid}) {
    return repository.single(uid: uid);
  }
}
