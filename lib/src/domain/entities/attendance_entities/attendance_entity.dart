import 'package:asco/src/domain/entities/profile_entities/user_profile_entity.dart';
import 'package:equatable/equatable.dart';

class AttendanceEntity extends Equatable {
  final UserProfileEntity? student;
  final int? attendanceStatus;
  final int? pointPlus;
  final DateTime? attendanceTime;
  final String? note;

  const AttendanceEntity({
    this.attendanceStatus,
    this.attendanceTime,
    this.note,
    this.pointPlus,
    this.student
  });

  @override
  List<Object?> get props => [
        student,
        attendanceStatus,
        pointPlus,
        attendanceTime,
        note,
      ];
}
