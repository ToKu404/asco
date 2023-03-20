import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/domain/repositories/classroom_repository.dart';

class UpdateStudentClassroom {
  final ClassroomRepository repository;

  UpdateStudentClassroom({required this.repository});

  Future<Either<Failure, bool>> execute({
    required String classroomUid,
    required List<ProfileEntity> students,
  }) {
    return repository.updateStudent(
      classroomUid: classroomUid,
      students: students,
    );
  }
}
