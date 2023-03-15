import 'package:equatable/equatable.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_attendance_entity.dart';
import 'package:asco/src/domain/entities/meeting_entities/meeting_entity.dart';

class ControlCardEntity extends Equatable {
  final MeetingEntity? meeting;
  final AssistanceAttendanceEntity? assistance1;
  final AssistanceAttendanceEntity? assistance2;

  const ControlCardEntity({
    this.meeting,
    this.assistance1,
    this.assistance2,
  });

  @override
  List<Object?> get props => [
        meeting,
        assistance1,
        assistance2,
      ];
}
