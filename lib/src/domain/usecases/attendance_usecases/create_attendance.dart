import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/meeting_entities/meeting_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/repositories/attendances_repository.dart';
import 'package:dartz/dartz.dart';

class CreateAttendance {
  final AttendancesRepository repository;

  CreateAttendance({required this.repository});

  Future<Either<Failure, bool>> execute({
    required MeetingEntity meeting,
    required String classroomUid,
    required List<DetailProfileEntity> students,
  }) {
    return repository.create(
      meeting: meeting,
      classroomUid: classroomUid,
      students: students,
    );
  }
}
