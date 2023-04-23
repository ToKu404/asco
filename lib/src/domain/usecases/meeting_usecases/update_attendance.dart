import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:asco/src/domain/repositories/meeting_repository.dart';

class UpdateAttendance {
  final MeetingRepository repository;

  UpdateAttendance({required this.repository});

  Future<Either<Failure, bool>> execute({
    required String uid,
    required List<AttendanceEntity> listAttendanceModel,
  }) {
    return repository.updateAttendance(
      uid: uid,
      listAttendanceModel: listAttendanceModel,
    );
  }
}
