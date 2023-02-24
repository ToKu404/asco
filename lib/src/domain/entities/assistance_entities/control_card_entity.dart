import 'package:asco/src/domain/entities/assistance_entities/assistance_attendance_entity.dart';
import 'package:asco/src/domain/entities/meeting_entities/meeting_entity.dart';
import 'package:equatable/equatable.dart';

class ControlCardEntity extends Equatable {
  final MeetingEntity? meeting;
  final AssistanceAttendanceEntity? assistance1;
  final AssistanceAttendanceEntity? assistance2;

  const ControlCardEntity({
    this.assistance1,
    this.assistance2,
    this.meeting,
  });

  @override
  List<Object?> get props => [
        assistance1,
        meeting,
        assistance2,
      ];
}
