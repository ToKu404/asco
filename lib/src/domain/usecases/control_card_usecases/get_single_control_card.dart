import 'package:asco/src/domain/entities/assistance_entities/assistance_entities.dart';
import 'package:asco/src/domain/repositories/control_card_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';

class GetSingleControlCard {
  final ControlCardRepository repository;

  GetSingleControlCard({required this.repository});

  Future<Either<Failure, ControlCardEntity>> execute({
    required String uuid,
  }) {
    return repository.single(
      uid: uuid,
    );
  }
}
