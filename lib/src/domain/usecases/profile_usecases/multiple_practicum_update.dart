import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/user_practicum_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/user_practicum_helper.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class MultiplePracticumUpdate {
  final ProfileRepository repository;

  MultiplePracticumUpdate({required this.repository});

  Future<Either<Failure, bool>> execute(
      {required Map<String, Map<String, UserPracticumHelper>> data}) {
    return repository.multiplePracticumUpdate(data: data);
  }
}
