import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/user_profile_entity.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class GetSingleProfile {
  final ProfileRepository profileRepository;

  GetSingleProfile({required this.profileRepository});

  Future<Either<Failure, UserProfileEntity>> execute(
      {required String username}) {
    return profileRepository.single(username: username);
  }
}
