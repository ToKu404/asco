import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';

class AttendanceModel extends AttendanceEntity {
  const AttendanceModel({
    required super.studentUid,
    required super.attendanceTime,
    required super.attendanceStatus,
    required super.pointPlus,
    required super.note,
  });

  Map<String, dynamic> toDocument() {
    return {
      'student_uid': studentUid,
      'attendance_time': attendanceTime,
      'attendance_status': attendanceStatus,
      'point_plus': pointPlus,
      'note': note,
    };
  }

  AttendanceEntity toEntity() {
    return AttendanceEntity(
      uuid: uuid,
      studentUid: studentUid,
      attendanceTime: attendanceTime,
      attendanceStatus: attendanceStatus,
      pointPlus: pointPlus,
      note: note,
    );
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return AttendanceModel(
      studentUid: documentSnapshot['student_uid'],
      attendanceTime: documentSnapshot['attendance_time'],
      attendanceStatus: documentSnapshot['attendance_status'],
      pointPlus: documentSnapshot['point_plus'],
      note: documentSnapshot['note'],
    );
  }

  factory AttendanceModel.fromEntity(AttendanceEntity entity) {
    return AttendanceModel(
      studentUid: entity.studentUid,
      attendanceTime: entity.attendanceTime,
      attendanceStatus: entity.attendanceStatus,
      pointPlus: entity.pointPlus,
      note: entity.note,
    );
  }
}
