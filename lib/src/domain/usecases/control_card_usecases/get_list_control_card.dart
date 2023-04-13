import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_entities.dart';
import 'package:asco/src/domain/repositories/control_card_repository.dart';

class GetListControlCard {
  final ControlCardRepository repository;

  GetListControlCard({required this.repository});

  Future<Either<Failure, ControlCardResultEntity>> execute({
    required String id,
  }) {
    return repository.find(studentId: id);
  }
}
