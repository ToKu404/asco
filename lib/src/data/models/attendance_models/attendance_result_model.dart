import 'package:asco/src/domain/entities/attendance_entities/attendance_result_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceResultModel extends AttendanceResultEntity {
  const AttendanceResultModel({
    required super.attendances,
    required super.meetingUid,
    required super.uid,
  });

  Map<String, dynamic> toDocument() {
    return {
      "attendances": attendances,
      "meeting_uid": meetingUid,
      "uid": uid,
    };
  }

  AttendanceResultEntity toEntity() {
    return AttendanceResultEntity(
      attendances: attendances,
      meetingUid: meetingUid,
      uid: uid,
    );
  }

  factory AttendanceResultModel.fromSnapshot(
      DocumentSnapshot documentSnapshot) {
    return AttendanceResultModel(
      attendances: documentSnapshot['attendances'],
      meetingUid: documentSnapshot['meeting_uid'],
      uid: documentSnapshot['uid'],
    );
  }

  factory AttendanceResultModel.fromEntity(AttendanceResultEntity entity) {
    return AttendanceResultModel(
      attendances: entity.attendances,
      meetingUid: entity.meetingUid,
      uid: entity.uid,
    );
  }
}
