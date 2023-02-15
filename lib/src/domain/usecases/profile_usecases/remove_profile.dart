import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveProfile {
  final ProfileRepository profileRepository;

  RemoveProfile({required this.profileRepository});

  Future<Either<Failure, bool>> execute({required String uid}) {
    return profileRepository.remove(uid: uid);
  }
}
