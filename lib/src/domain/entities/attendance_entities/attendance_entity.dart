import 'package:equatable/equatable.dart';

class AttendanceEntity extends Equatable {
  final String? studentUid;
  final int? attendanceStatus;
  final int? pointPlus;
  final DateTime? attendanceTime;
  final String? note;
  final String? uuid;

  const AttendanceEntity({
    this.attendanceStatus,
    this.attendanceTime,
    this.note,
    this.pointPlus,
    this.uuid,
    this.studentUid,
  });

  @override
  List<Object?> get props => [
        studentUid,
        attendanceStatus,
        pointPlus,
        attendanceTime,
        uuid,
        note,
      ];
}
