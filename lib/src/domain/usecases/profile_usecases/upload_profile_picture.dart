import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';

class UploadProfilePicture {
  final ProfileRepository repository;

  UploadProfilePicture({required this.repository});

  Future<Either<Failure, String>> execute(
    String path,
    String uid,
    String filename,
  ) {
    return repository.uploadProfilePicture(path, uid, filename);
  }
}
