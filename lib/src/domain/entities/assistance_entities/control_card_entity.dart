import 'package:asco/src/domain/entities/assistance_entities/assistance_attendance_entity.dart';
import 'package:asco/src/domain/entities/meeting_entities/meeting_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:equatable/equatable.dart';

class ControlCardEntity extends Equatable {
  final String? uid;
  final ProfileEntity? student;
  final MeetingEntity? meeting;
  final AssistanceAttendanceEntity? assistance1;
  final AssistanceAttendanceEntity? assistance2;

  const ControlCardEntity({
    this.assistance1,
    this.assistance2,
    this.meeting,
    this.student,
    this.uid,
  });

  @override
  List<Object?> get props => [
        uid,
        student,
        meeting,
        assistance1,
        assistance2,
      ];
}
