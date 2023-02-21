import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MeetingRepository {
  Future<Either<Failure, bool>> create({
    required DetailMeetingEntity meeting,
  });
  Future<Either<Failure, DetailMeetingEntity>> single({required String uid});
  Future<Either<Failure, List<DetailMeetingEntity>>> find({
    String? classroomUid,
  });
}
