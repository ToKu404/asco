import 'package:asco/core/utils/failure.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:asco/src/domain/repositories/meeting_repository.dart';
import 'package:dartz/dartz.dart';

class GetSingleMeeting {
  final MeetingRepository repository;

  GetSingleMeeting({required this.repository});

  Future<Either<Failure, DetailMeetingEntity>> execute({required String uid}) {
    return repository.single(uid: uid);
  }
}
