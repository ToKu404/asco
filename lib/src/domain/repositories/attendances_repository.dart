import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_result_entity.dart';
import 'package:asco/src/domain/entities/meeting_entities/meeting_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AttendancesRepository {
  Future<Either<Failure, bool>> create({
    required MeetingEntity meeting,
    required String classroomUid,
    required List<DetailProfileEntity> students,
  });
  Future<Either<Failure, bool>> update({
    required String uid,
    required AttendanceEntity attendance,
    required AttendanceEntity oldAttendance,
  });
  Future<Either<Failure, AttendanceResultEntity>> single(
      {required String meetingUid, required String classroomUid});
  Future<Either<Failure, List<AttendanceResultEntity>>> find({
    required String classroomUid,
  });
}
