import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class GetListProfile {
  final ProfileRepository repository;

  GetListProfile({required this.repository});

  Future<Either<Failure, List<DetailProfileEntity>>> execute({
    String? query,
    int? byRole,
  }) {
    return repository.find(
      query: query,
      byRole: byRole,
    );
  }
}
