import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/user_profile_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, bool>> create(
      {required UserProfileEntity userProfileEntity});
  Future<Either<Failure, UserProfileEntity>> single({required String uid});
  Future<Either<Failure, UserProfileEntity>> me();
  Future<Either<Failure, bool>> update(
      {required UserProfileEntity userProfileEntity});
  Future<Either<Failure, bool>> remove({required String uid});
  Future<Either<Failure, List<UserProfileEntity>>> find({
    String? query,
    int? byRole,
  });
}
