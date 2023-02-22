import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_result_entity.dart';
import 'package:asco/src/domain/repositories/attendances_repository.dart';
import 'package:dartz/dartz.dart';

class GetSingleAttendance {
  final AttendancesRepository repository;

  GetSingleAttendance({required this.repository});

  Future<Either<Failure, AttendanceResultEntity>> execute({
    required String meetingUid,
    required String classroomUid,
  }) {
    return repository.single(
      classroomUid: classroomUid,
      meetingUid: meetingUid,
    );
  }
}
