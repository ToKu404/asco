import 'package:asco/src/data/models/profile_models/profile_model.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';

class AttendanceModel extends AttendanceEntity {
  const AttendanceModel({
    required super.attendanceStatus,
    required super.attendanceTime,
    required super.note,
    required super.pointPlus,
    required super.student,
    required super.uuid,
  });

  Map<String, dynamic> toDocument() {
    return {
      'attendance_status': attendanceStatus,
      'attendance_time': attendanceTime,
      'note': note,
      'point_plus': pointPlus,
      'student': ProfileModel.fromEntity(student!).toDocument(),
      'uuid': uuid,
    };
  }

  AttendanceEntity toEntity() {
    return AttendanceEntity(
      attendanceStatus: attendanceStatus,
      attendanceTime: attendanceTime,
      note: note,
      pointPlus: pointPlus,
      student: student,
      uuid: uuid,
    );
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return AttendanceModel(
      attendanceStatus: documentSnapshot['attendance_status'],
      attendanceTime: documentSnapshot['attendance_time'],
      note: documentSnapshot['note'],
      pointPlus: documentSnapshot['point_plus'],
      uuid: documentSnapshot['uuid'],
      student: ProfileModel.fromMap(documentSnapshot['student']).toEntity(),
    );
  }

  factory AttendanceModel.fromEntity(AttendanceEntity entity) {
    return AttendanceModel(
      attendanceStatus: entity.attendanceStatus,
      attendanceTime: entity.attendanceTime,
      note: entity.note,
      pointPlus: entity.pointPlus,
      student: entity.student,
      uuid: entity.uuid,
    );
  }
}
