import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/domain/repositories/practicum_repository.dart';

class UpdatePracticumAssistant {
  final PracticumRepository repository;

  UpdatePracticumAssistant({required this.repository});

  Future<Either<Failure, bool>> execute({
    required String practicumUid,
    required List<ProfileEntity> assistants,
  }) {
    return repository.updateAssistants(
      practicumUid: practicumUid,
      assistants: assistants,
    );
  }
}
