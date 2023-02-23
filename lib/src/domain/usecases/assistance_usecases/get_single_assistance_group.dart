import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_entity.dart';
import 'package:asco/src/domain/repositories/assitances_repository.dart';
import 'package:dartz/dartz.dart';

class GetSingleAssistanceGroup {
  final AssistancesGroupRepository repository;

  GetSingleAssistanceGroup({required this.repository});

  Future<Either<Failure, AssistanceGroupEntity>> execute(
      {required String uuid, String? assistant}) {
    return repository.single(
      uuid: uuid,
      assistant: assistant,
    );
  }
}
