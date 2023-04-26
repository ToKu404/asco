import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/repositories/control_card_repository.dart';
import 'package:dartz/dartz.dart';

import '../../entities/assistance_entities/assistance_entities.dart';

class GetMultipleControlCard {
  final ControlCardRepository repository;

  GetMultipleControlCard({required this.repository});

  Future<Either<Failure, List<ControlCardResultEntity>>> execute({
    required List<String> listId,
  }) {
    return repository.multiple(multipleId: listId);
  }
}
