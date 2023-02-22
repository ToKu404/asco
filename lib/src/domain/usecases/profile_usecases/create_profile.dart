import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class CreateProfile {
  final ProfileRepository repository;

  CreateProfile({required this.repository});

  Future<Either<Failure, bool>> execute(
      {required DetailProfileEntity userEntity}) {
    return repository.create(userProfileEntity: userEntity);
  }
}
