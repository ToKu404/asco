import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/user_profile_entity.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class GetListProfile {
  final ProfileRepository profileRepository;

  GetListProfile({required this.profileRepository});

  Future<Either<Failure, List<UserProfileEntity>>> execute() {
    return profileRepository.find();
  }
}
