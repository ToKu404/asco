import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';

class DeleteProfilePicture {
  final ProfileRepository repository;

  DeleteProfilePicture({required this.repository});

  Future<Either<Failure, void>> execute(String uid, String filename) {
    return repository.deleteProfilePicture(uid, filename);
  }
}
