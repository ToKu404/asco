import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';

class RemoveProfile {
  final ProfileRepository repository;

  RemoveProfile({required this.repository});

  Future<Either<Failure, bool>> execute({required String uid}) {
    return repository.remove(uid: uid);
  }
}
