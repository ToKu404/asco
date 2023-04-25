import 'package:equatable/equatable.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';

class DetailMeetingEntity extends Equatable {
  final String? uid;
  final String? classUid;
  final String? assistant1Uid;
  final String? assistant2Uid;
  final DateTime? meetingDate;
  final String? topic;
  final String? modulPath;
  final int? meetingNumber;
  final int? maxQuizScore;
  final List<AttendanceEntity>? attendances;

  const DetailMeetingEntity({
    this.uid,
    this.classUid,
    this.assistant1Uid,
    this.assistant2Uid,
    this.meetingDate,
    this.topic,
    this.modulPath,
    this.meetingNumber,
    this.attendances,
    this.maxQuizScore,
  });

  @override
  List<Object?> get props => [
        uid,
        classUid,
        assistant1Uid,
        assistant2Uid,
        meetingDate,
        topic,
        modulPath,
        attendances,
        meetingNumber,
        maxQuizScore,
      ];
}
