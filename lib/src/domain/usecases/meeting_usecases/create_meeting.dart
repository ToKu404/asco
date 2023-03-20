import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:asco/src/domain/repositories/meeting_repository.dart';

class CreateMeeting {
  final MeetingRepository repository;

  CreateMeeting({required this.repository});

  Future<Either<Failure, bool>> execute({
    required DetailMeetingEntity meeting,
    required List<String> listStudentId,
  }) {
    return repository.create(
      meeting: meeting,
      listStudentId: listStudentId,
    );
  }
}
