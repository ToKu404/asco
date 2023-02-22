import 'package:equatable/equatable.dart';

class DetailMeetingEntity extends Equatable {
  final String? uid;
  final String? classUid;
  final String? topic;
  final DateTime? meetingDate;
  final String? modulPath;
  final String? assistant1Uid;
  final String? assistant2Uid;

  const DetailMeetingEntity({
    this.assistant1Uid,
    this.meetingDate,
    this.assistant2Uid,
    this.classUid,
    this.modulPath,
    this.topic,
    this.uid,
  });

  @override
  List<Object?> get props => [
        uid,
        assistant1Uid,
        assistant2Uid,
        classUid,
        modulPath,
        topic,
      ];
}
