import 'package:equatable/equatable.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';

class MeetingEntity extends Equatable {
  final String? uid;
  final String? topic;
  final DateTime? meetingDate;

  const MeetingEntity({
    this.uid,
    this.topic,
    this.meetingDate,
  });

  factory MeetingEntity.fromDetail(DetailMeetingEntity detail) {
    return MeetingEntity(
      uid: detail.uid,
      topic: detail.topic,
      meetingDate: detail.meetingDate,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        topic,
        meetingDate,
      ];
}
