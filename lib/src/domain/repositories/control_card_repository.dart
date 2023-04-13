import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/assistance_entities/control_card_entity.dart';
import 'package:asco/src/domain/entities/assistance_entities/control_card_result_entity.dart';

abstract class ControlCardRepository {
  Future<Either<Failure, bool>> initForStudent({
    required String practicumUid,
    required List<String>? addedStudentId,
    required List<String>? removeStudentId,
  });

  Future<Either<Failure, ControlCardEntity>> single({required String uid});

  Future<Either<Failure, ControlCardResultEntity>> find({String? studentId});
}
