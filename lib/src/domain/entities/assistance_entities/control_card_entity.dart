import 'package:equatable/equatable.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_attendance_entity.dart';

class ControlCardEntity extends Equatable {
  final int? meetingNumber;
  final AssistanceAttendanceEntity? assistance1;
  final AssistanceAttendanceEntity? assistance2;

  const ControlCardEntity({
    this.meetingNumber,
    this.assistance1,
    this.assistance2,
  });

  @override
  List<Object?> get props => [
        meetingNumber,
        assistance1,
        assistance2,
      ];
}
