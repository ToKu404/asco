import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/domain/repositories/assistance_repository.dart';

class UpdateStudentAssistanceGroup {
  final AssistanceGroupRepository repository;

  UpdateStudentAssistanceGroup({required this.repository});

  Future<Either<Failure, bool>> execute({
    required List<ProfileEntity> students,
    required String assistanceGroupUid,
  }) {
    return repository.updateStudents(
      students: students,
      assistantGroupUid: assistanceGroupUid,
    );
  }
}
