import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/user_profile_entity.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateProfile {
  final ProfileRepository profileRepository;

  UpdateProfile({required this.profileRepository});

  Future<Either<Failure, bool>> execute({
    required UserProfileEntity userProfileEntity,
  }) {
    return profileRepository.update(userProfileEntity: userProfileEntity);
  }
}
