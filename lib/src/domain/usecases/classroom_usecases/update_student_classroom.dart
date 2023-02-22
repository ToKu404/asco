import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/domain/repositories/classroom_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateStudentClassroom {
  final ClassroomRepository repository;

  UpdateStudentClassroom({required this.repository});

  Future<Either<Failure, bool>> execute({
    required List<ProfileEntity> students,
    required String classroomUid,
  }) {
    return repository.updateStudent(
      students: students,
      classroomUid: classroomUid,
    );
  }
}
