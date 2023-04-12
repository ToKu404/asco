import 'package:equatable/equatable.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';

class MeetingEntity extends Equatable {
  final String? uid;
  final int? meetingNumber;
  final String? topic;
  final DateTime? meetingDate;

  const MeetingEntity({
    this.uid,
    this.topic,
    this.meetingNumber,
    this.meetingDate,
  });

  factory MeetingEntity.fromDetail(DetailMeetingEntity detail) {
    return MeetingEntity(
      uid: detail.uid,
      topic: detail.topic,
      meetingNumber: detail.meetingNumber,
      meetingDate: detail.meetingDate,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        topic,
        meetingNumber,
        meetingDate,
      ];
}
