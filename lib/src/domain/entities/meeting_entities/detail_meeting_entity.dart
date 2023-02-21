import 'package:asco/src/domain/entities/profile_entities/user_profile_entity.dart';
import 'package:equatable/equatable.dart';

class DetailMeetingEntity extends Equatable {
  final String? uid;
  final String? classUid;
  final String? topic;
  final DateTime? meetingDate;
  final String? modulPath;
  final UserProfileEntity? assistant1;
  final UserProfileEntity? assistant2;

  const DetailMeetingEntity({
    this.assistant1,
    this.meetingDate,
    this.assistant2,
    this.classUid,
    this.modulPath,
    this.topic,
    this.uid,
  });

  @override
  List<Object?> get props => [
        uid,
        assistant1,
        assistant2,
        classUid,
        modulPath,
        topic,
      ];
}
