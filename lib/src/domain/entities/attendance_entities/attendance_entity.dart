import 'package:equatable/equatable.dart';

class AttendanceEntity extends Equatable {
  final String? uuid;
  final String? studentUid;
  final DateTime? attendanceTime;
  final int? attendanceStatus;
  final int? pointPlus;
  final String? note;

  const AttendanceEntity({
    this.uuid,
    this.studentUid,
    this.attendanceTime,
    this.attendanceStatus,
    this.pointPlus,
    this.note,
  });

  @override
  List<Object?> get props => [
        uuid,
        studentUid,
        attendanceTime,
        attendanceStatus,
        pointPlus,
        note,
      ];
}
