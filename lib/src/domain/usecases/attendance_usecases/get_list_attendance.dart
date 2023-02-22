import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_result_entity.dart';
import 'package:asco/src/domain/repositories/attendances_repository.dart';
import 'package:dartz/dartz.dart';

class GetListAttendance {
  final AttendancesRepository repository;

  GetListAttendance({required this.repository});

  Future<Either<Failure, List<AttendanceResultEntity>>> execute({
    required String classroomUid,
  }) {
    return repository.find(
      classroomUid: classroomUid,
    );
  }
}
