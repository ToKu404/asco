import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/assistance_entities/control_card_result_entity.dart';
import 'package:asco/src/domain/repositories/control_card_repository.dart';

class GetMultipleControlCard {
  final ControlCardRepository repository;

  GetMultipleControlCard({required this.repository});

  Future<Either<Failure, List<ControlCardResultEntity>>> execute({
    required List<String> listId,
  }) {
    return repository.multiple(multipleId: listId);
  }
}
