import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/assistance_entities/control_card_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ControlCardRepository {
  Future<Either<Failure, bool>> create({
    required ControlCardEntity cc,
  });
  Future<Either<Failure, ControlCardEntity>> single({required String uid});
  Future<Either<Failure, List<ControlCardEntity>>> find({
    String? studentId,
  });
}
