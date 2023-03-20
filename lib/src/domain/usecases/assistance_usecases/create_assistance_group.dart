import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_group_entity.dart';
import 'package:asco/src/domain/repositories/assistance_repository.dart';

class CreateAssistanceGroup {
  final AssistanceGroupRepository repository;

  CreateAssistanceGroup({required this.repository});

  Future<Either<Failure, bool>> execute({
    required AssistanceGroupEntity assistanceGroup,
  }) {
    return repository.create(assistanceGroup: assistanceGroup);
  }
}
