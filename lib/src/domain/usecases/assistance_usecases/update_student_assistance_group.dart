import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/domain/repositories/assitances_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateStudentAssistanceGroup {
  final AssistancesGroupRepository repository;

  UpdateStudentAssistanceGroup({required this.repository});

  Future<Either<Failure, bool>> execute({
    required List<ProfileEntity> students,
    required String assistanceGroupUid,
  }) {
    return repository.updateStudent(
      students: students,
      assistantGroupUid: assistanceGroupUid,
    );
  }
}
