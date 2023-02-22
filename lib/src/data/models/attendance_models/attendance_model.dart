import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';

class AttendanceModel extends AttendanceEntity {
  const AttendanceModel({
    required super.attendanceStatus,
    required super.attendanceTime,
    required super.note,
    required super.pointPlus,
    required super.studentUid,
  });

  Map<String, dynamic> toDocument() {
    return {
      'attendance_status': attendanceStatus,
      'attendance_time': attendanceTime,
      'note': note,
      'point_plus': pointPlus,
      'student_uid': studentUid,
    };
  }

  AttendanceEntity toEntity() {
    return AttendanceEntity(
      attendanceStatus: attendanceStatus,
      attendanceTime: attendanceTime,
      note: note,
      pointPlus: pointPlus,
      studentUid: studentUid,
      uuid: uuid,
    );
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return AttendanceModel(
      attendanceStatus: documentSnapshot['attendance_status'],
      attendanceTime: documentSnapshot['attendance_time'],
      note: documentSnapshot['note'],
      pointPlus: documentSnapshot['point_plus'],
      studentUid: documentSnapshot['student_uid'],
    );
  }

  factory AttendanceModel.fromEntity(AttendanceEntity entity) {
    return AttendanceModel(
      attendanceStatus: entity.attendanceStatus,
      attendanceTime: entity.attendanceTime,
      note: entity.note,
      pointPlus: entity.pointPlus,
      studentUid: entity.studentUid,
    );
  }
}
