import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class SelfProfile {
  final ProfileRepository repository;

  SelfProfile({required this.repository});

  Future<Either<Failure, DetailProfileEntity>> execute() {
    return repository.me();
  }
}
