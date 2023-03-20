import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';

class GetMultipleProfile {
  final ProfileRepository repository;

  GetMultipleProfile({required this.repository});

  Future<Either<Failure, List<DetailProfileEntity>>> execute({
    required List<String> multipleId,
  }) {
    return repository.multiple(multipleId: multipleId);
  }
}
