import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_entity.dart';
import 'package:asco/src/domain/repositories/assitances_repository.dart';
import 'package:dartz/dartz.dart';

class GetListAssistanceGroup {
  final AssistancesGroupRepository repository;

  GetListAssistanceGroup({required this.repository});

  Future<Either<Failure, List<AssistanceGroupEntity>>> execute({
    required String practicumUid,
  }) {
    return repository.find(practicumUid: practicumUid);
  }
}
