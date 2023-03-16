import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_group_entity.dart';
import 'package:asco/src/domain/repositories/assistance_repository.dart';

class GetListAssistanceGroup {
  final AssistanceGroupRepository repository;

  GetListAssistanceGroup({required this.repository});

  Future<Either<Failure, List<AssistanceGroupEntity>>> execute({
    required String practicumUid,
  }) {
    return repository.find(practicumUid: practicumUid);
  }
}
