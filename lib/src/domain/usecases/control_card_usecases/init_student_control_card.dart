import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/repositories/control_card_repository.dart';

class InitStudentControlCard {
  final ControlCardRepository repository;

  InitStudentControlCard({required this.repository});

  Future<Either<Failure, bool>> execute({
    required String practicumUid,
    required List<String>? addedStudentId,
    required List<String>? removeStudentId,
  }) {
    return repository.initForStudent(
      practicumUid: practicumUid,
      addedStudentId: addedStudentId,
      removeStudentId: removeStudentId,
    );
  }
}
