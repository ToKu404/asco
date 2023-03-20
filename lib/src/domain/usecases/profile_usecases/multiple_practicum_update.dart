import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/user_practicum_helper.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';

class UpdateMultiplePracticums {
  final ProfileRepository repository;

  UpdateMultiplePracticums({required this.repository});

  Future<Either<Failure, bool>> execute({
    required Map<String, Map<String, UserPracticumHelper>> data,
  }) {
    return repository.updateMultiplePracticums(data: data);
  }
}
