import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:equatable/equatable.dart';

class AttendanceResultEntity extends Equatable {
  final String? uid;
  final String? meetingUid;
  final List<AttendanceEntity>? attendances;

  const AttendanceResultEntity({
    this.attendances,
    this.meetingUid,
    this.uid,
  });

  @override
  List<Object?> get props => [
        uid,
        meetingUid,
        attendances,
      ];
}
