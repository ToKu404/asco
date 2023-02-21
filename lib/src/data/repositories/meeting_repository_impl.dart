import 'package:asco/src/data/datasources/meeting_datasources.dart';
import 'package:asco/src/data/models/meeting_models/detail_meeting_model.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:asco/src/domain/repositories/meeting_repository.dart';
import 'package:dartz/dartz.dart';

class MeetingRepositoryImpl implements MeetingRepository {
  final MeetingDataSourceImpl dataSource;

  MeetingRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, bool>> create(
      {required DetailMeetingEntity meeting}) async {
    try {
      final result = await dataSource.create(
        meeting: DetailMeetingModel.fromEntity(meeting),
      );
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<DetailMeetingEntity>>> find(
      {String? classroomUid}) async {
    try {
      final result = await dataSource.find(
        classroomUid: classroomUid,
      );

      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }

  @override
  Future<Either<Failure, DetailMeetingEntity>> single(
      {required String uid}) async {
    try {
      final result = await dataSource.single(uid: uid);
      return Right(result);
    } catch (e) {
      return const Left(FirestoreFailure(''));
    }
  }
}