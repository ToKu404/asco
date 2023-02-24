import 'package:asco/src/domain/entities/assistance_entities/control_card_entity.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:equatable/equatable.dart';

class DetailMeetingEntity extends Equatable {
  final String? uid;
  final String? classUid;
  final String? topic;
  final DateTime? meetingDate;
  final String? modulPath;
  final String? assistant1Uid;
  final String? assistant2Uid;
  final List<AttendanceEntity>? attendances;

  const DetailMeetingEntity({
    this.assistant1Uid,
    this.meetingDate,
    this.assistant2Uid,
    this.classUid,
    this.modulPath,
    this.topic,
    this.uid,
    this.attendances,
  });

  @override
  List<Object?> get props => [
        uid,
        assistant1Uid,
        assistant2Uid,
        classUid,
        modulPath,
        topic,
        attendances,
      ];
}
