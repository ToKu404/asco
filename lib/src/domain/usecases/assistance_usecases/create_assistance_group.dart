import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_entity.dart';
import 'package:asco/src/domain/repositories/assitances_repository.dart';
import 'package:dartz/dartz.dart';

class CreateAssistanceGroup {
  final AssistancesGroupRepository repository;

  CreateAssistanceGroup({required this.repository});

  Future<Either<Failure, bool>> execute({
    required AssistanceGroupEntity entity,
  }) {
    return repository.create(
      entity: entity,
    );
  }
}
