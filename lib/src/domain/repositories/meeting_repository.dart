import 'package:asco/src/domain/entities/attendance_entities/attendance_entities.dart';
import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';

abstract class MeetingRepository {
  Future<Either<Failure, bool>> create({
    required DetailMeetingEntity meeting,
    required List<String> listStudentId,
  });
  Future<Either<Failure, bool>> updateAttendance(
      {required List<AttendanceEntity> listAttendanceModel,
      required String uid});
  Future<Either<Failure, DetailMeetingEntity>> single({required String uid});

  Future<Either<Failure, List<DetailMeetingEntity>>> find({
    String? classroomUid,
  });
}
