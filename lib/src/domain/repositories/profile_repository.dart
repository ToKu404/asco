import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/user_practicum_helper.dart';

abstract class ProfileRepository {
  Future<Either<Failure, bool>> create({
    required DetailProfileEntity userProfileEntity,
  });

  Future<Either<Failure, bool>> update({
    required DetailProfileEntity userProfileEntity,
  });

  Future<Either<Failure, bool>> updateMultiplePracticums({
    required Map<String, Map<String, UserPracticumHelper>> data,
  });

  Future<Either<Failure, bool>> remove({required String uid});

  Future<Either<Failure, DetailProfileEntity>> self();

  Future<Either<Failure, DetailProfileEntity>> single({required String uid});

  Future<Either<Failure, List<DetailProfileEntity>>> multiple({
    required List<String> multipleId,
  });

  Future<Either<Failure, List<DetailProfileEntity>>> find({
    String? query,
    int? roleId,
    String? practicumUid,
  });

  Future<Either<Failure, String>> uploadProfilePicture(
    String path,
    String uid,
    String filename,
  );

  Future<Either<Failure, void>> deleteProfilePicture(
    String uid,
    String filename,
  );
}
