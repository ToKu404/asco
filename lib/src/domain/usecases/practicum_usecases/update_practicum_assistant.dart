import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/domain/repositories/practicum_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePracticumAssistant {
  final PracticumRepository repository;

  UpdatePracticumAssistant({required this.repository});

  Future<Either<Failure, bool>> execute({
    required List<ProfileEntity> assistants,
    required String practicumUid,
  }) {
    return repository.updateAssistants(
      assistants: assistants,
      practicumUid: practicumUid,
    );
  }
}
