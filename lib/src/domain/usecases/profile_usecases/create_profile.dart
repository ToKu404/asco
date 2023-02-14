import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/user_profile_entity.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class CreateProfile {
  final ProfileRepository profileRepository;

  CreateProfile({required this.profileRepository});

  Future<Either<Failure, bool>> execute(
      {required UserProfileEntity userEntity}) {
    return profileRepository.create(userProfileEntity: userEntity);
  }
}
