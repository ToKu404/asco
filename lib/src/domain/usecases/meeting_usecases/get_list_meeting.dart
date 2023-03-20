import 'package:dartz/dartz.dart';
import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:asco/src/domain/repositories/meeting_repository.dart';

class GetListMeeting {
  final MeetingRepository repository;

  GetListMeeting({required this.repository});

  Future<Either<Failure, List<DetailMeetingEntity>>> execute({
    String? classroomUid,
  }) {
    return repository.find(classroomUid: classroomUid);
  }
}
