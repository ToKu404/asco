import 'package:asco/src/domain/entities/attendance_entities/attendance_result_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceResultModel extends AttendanceResultEntity {
  const AttendanceResultModel({
    required super.attendances,
    required super.meeting,
    required super.uid,
    required super.classroomUid,
  });

  Map<String, dynamic> toDocument() {
    return {
      "attendances": attendances,
      "meeting": meeting,
      "uid": uid,
      "classroom_uid": classroomUid,
    };
  }

  AttendanceResultEntity toEntity() {
    return AttendanceResultEntity(
        attendances: attendances,
        meeting: meeting,
        uid: uid,
        classroomUid: classroomUid);
  }

  factory AttendanceResultModel.fromSnapshot(
      DocumentSnapshot documentSnapshot) {
    return AttendanceResultModel(
      attendances: documentSnapshot['attendances'],
      meeting: documentSnapshot['meeting'],
      classroomUid: documentSnapshot['classroom_uid'],
      uid: documentSnapshot['uid'],
    );
  }

  factory AttendanceResultModel.fromEntity(AttendanceResultEntity entity) {
    return AttendanceResultModel(
      attendances: entity.attendances,
      meeting: entity.meeting,
      uid: entity.uid,
      classroomUid: entity.classroomUid,
    );
  }
}
