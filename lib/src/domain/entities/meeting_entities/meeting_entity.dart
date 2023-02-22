import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:equatable/equatable.dart';

class MeetingEntity extends Equatable {
  final String? uid;

  final String? topic;
  final DateTime? meetingDate;

  const MeetingEntity({
    this.meetingDate,
    this.topic,
    this.uid,
  });

  factory MeetingEntity.fromDetail(DetailMeetingEntity detail) {
    return MeetingEntity(
      meetingDate: detail.meetingDate,
      topic: detail.topic,
      uid: detail.uid,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        meetingDate,
        topic,
      ];
}
