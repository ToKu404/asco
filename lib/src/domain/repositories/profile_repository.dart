import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, bool>> create(
      {required DetailProfileEntity userProfileEntity});
  Future<Either<Failure, DetailProfileEntity>> single({required String uid});
  Future<Either<Failure, DetailProfileEntity>> me();
  Future<Either<Failure, bool>> update(
      {required DetailProfileEntity userProfileEntity});
  Future<Either<Failure, bool>> remove({required String uid});
  Future<Either<Failure, List<DetailProfileEntity>>> find({
    String? query,
    int? byRole,
  });
  Future<Either<Failure, List<DetailProfileEntity>>> multiple({
    required List<String> multipleId,
  });
}
