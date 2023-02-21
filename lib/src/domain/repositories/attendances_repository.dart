import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_result_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AttendancesRepository {
  Future<Either<Failure, bool>> create({
    required AttendanceResultEntity attendances,
  });
  Future<Either<Failure, bool>> add({
    required String uid,
    required AttendanceEntity attendance,
  });
  Future<Either<Failure, AttendanceResultEntity>> single(
      {required String meetingUid, required String classroomUid});
  Future<Either<Failure, List<AttendanceResultEntity>>> find({
    required String classroomUid,
  });
}
