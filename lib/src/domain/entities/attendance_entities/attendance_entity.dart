import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:equatable/equatable.dart';

class AttendanceEntity extends Equatable {
  final ProfileEntity? student;
  final int? attendanceStatus;
  final int? pointPlus;
  final DateTime? attendanceTime;
  final String? note;
  final String? uuid;

  const AttendanceEntity(
      {this.attendanceStatus,
      this.attendanceTime,
      this.note,
      this.pointPlus,
      this.uuid,
      this.student});

  @override
  List<Object?> get props => [
        student,
        attendanceStatus,
        pointPlus,
        attendanceTime,
        uuid,
        note,
      ];
}
