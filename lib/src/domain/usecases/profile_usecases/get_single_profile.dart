import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';

class GetSingleProfile {
  final ProfileRepository repository;

  GetSingleProfile({required this.repository});

  Future<Either<Failure, DetailProfileEntity>> execute({required String uid}) {
    return repository.single(uid: uid);
  }
}
