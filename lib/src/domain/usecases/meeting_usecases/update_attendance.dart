import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/repositories/meeting_repository.dart';

import '../../entities/attendance_entities/attendance_entities.dart';

class UpdateAttendance {
  final MeetingRepository repository;

  UpdateAttendance({required this.repository});

  Future<Either<Failure, bool>> execute(
      {required List<AttendanceEntity> listAttendanceModel,
      required String uid}) {
    return repository.updateAttendance(
      listAttendanceModel: listAttendanceModel,
      uid: uid,
    );
  }
}
