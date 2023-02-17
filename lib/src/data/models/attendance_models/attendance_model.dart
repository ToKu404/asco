import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';

class AttendanceModel extends AttendanceEntity {
  const AttendanceModel(
      {required super.attendanceStatus,
      required super.attendanceTime,
      required super.note,
      required super.pointPlus,
      required super.student});

  Map<String, dynamic> toDocument() {
    return {
      'attendance_status': attendanceStatus,
      'attendance_time': attendanceTime,
      'note': note,
      'point_plus': pointPlus,
      'student': student,
    };
  }

  AttendanceEntity toEntity() {
    return AttendanceEntity(
      attendanceStatus: attendanceStatus,
      attendanceTime: attendanceTime,
      note: note,
      pointPlus: pointPlus,
      student: student,
    );
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return AttendanceModel(
      attendanceStatus: documentSnapshot['attendance_status'],
      attendanceTime: documentSnapshot['attendance_time'],
      note: documentSnapshot['note'],
      pointPlus: documentSnapshot['point_plus'],
      student: documentSnapshot['student'],
    );
  }

  factory AttendanceModel.fromEntity(AttendanceEntity entity) {
    return AttendanceModel(
      attendanceStatus: entity.attendanceStatus,
      attendanceTime: entity.attendanceTime,
      note: entity.note,
      pointPlus: entity.pointPlus,
      student: entity.student,
    );
  }
}
