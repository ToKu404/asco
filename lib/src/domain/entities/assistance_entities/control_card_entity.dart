import 'package:asco/src/domain/entities/assistance_entities/assistance_attendance_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:equatable/equatable.dart';

class ControlCardEntity extends Equatable {
  final String? uid;
  final DetailProfileEntity? student;
  final String? meetingUid;
  final AssistanceAttendanceEntity? assistance1;
  final AssistanceAttendanceEntity? assistance2;

  const ControlCardEntity({
    this.assistance1,
    this.assistance2,
    this.meetingUid,
    this.student,
    this.uid,
  });

  @override
  List<Object?> get props => [
        uid,
        student,
        meetingUid,
        assistance1,
        assistance2,
      ];
}
