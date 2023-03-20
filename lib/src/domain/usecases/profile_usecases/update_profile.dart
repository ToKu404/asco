import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';

class UpdateProfile {
  final ProfileRepository repository;

  UpdateProfile({required this.repository});

  Future<Either<Failure, bool>> execute({
    required DetailProfileEntity userProfileEntity,
  }) {
    return repository.update(userProfileEntity: userProfileEntity);
  }
}
