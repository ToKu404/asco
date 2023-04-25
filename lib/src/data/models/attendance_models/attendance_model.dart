import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';

class AttendanceModel extends AttendanceEntity {
  const AttendanceModel({
    required super.studentUid,
    required super.attendanceTime,
    required super.attendanceStatus,
    required super.pointPlus,
    required super.note,
    required super.quizScore,
  });

  Map<String, dynamic> toDocument() {
    return {
      'student_uid': studentUid,
      'attendance_time': attendanceTime,
      'attendance_status': attendanceStatus,
      'point_plus': pointPlus,
      'note': note,
      'quiz_score': quizScore,
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
      quizScore: quizScore,
    );
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return AttendanceModel(
      studentUid: documentSnapshot['student_uid'],
      attendanceTime: documentSnapshot['attendance_time'] != null
          ? documentSnapshot['attendance_time']!.toDate()
          : null,
      attendanceStatus: documentSnapshot['attendance_status'],
      pointPlus: documentSnapshot['point_plus'],
      note: documentSnapshot['note'],
      quizScore: documentSnapshot['quiz_score'],
    );
  }

  factory AttendanceModel.fromEntity(AttendanceEntity entity) {
    return AttendanceModel(
      studentUid: entity.studentUid,
      attendanceTime: entity.attendanceTime,
      attendanceStatus: entity.attendanceStatus,
      pointPlus: entity.pointPlus,
      note: entity.note,
      quizScore: entity.quizScore,
    );
  }
}
