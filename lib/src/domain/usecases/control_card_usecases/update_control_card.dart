import 'package:asco/src/domain/entities/assistance_entities/assistance_entities.dart';
import 'package:asco/src/domain/repositories/control_card_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';

class UpdateControlCard {
  final ControlCardRepository repository;

  UpdateControlCard({required this.repository});

  Future<Either<Failure, bool>> execute({
    required String uid,
    required List<ControlCardEntity> listCC,
  }) {
    return repository.updateAssistance(
      uid: uid,
      listCC: listCC,
    );
  }
}
