import 'package:asco/src/domain/entities/assistance_entities/assistance_attendance_entity.dart';
import 'package:equatable/equatable.dart';

class ControlCardEntity extends Equatable {
  final AssistanceAttendanceEntity? assistance1;
  final AssistanceAttendanceEntity? assistance2;

  const ControlCardEntity({
    this.assistance1,
    this.assistance2,
  });

  @override
  List<Object?> get props => [
        assistance1,
        assistance2,
      ];
}
