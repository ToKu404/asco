import 'package:asco/src/domain/entities/assistance_entities/assistance_entity.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClassroomModel extends ClassroomEntity {
  const ClassroomModel({
    required super.startTime,
    required super.endTime,
    required super.meetingDay,
    required super.uid,
  });

  Map<String, dynamic> toDocument() {
    return {
      "start_time": startTime,
      "end_time": endTime,
      "meeting_day": meetingDay,
      "uid": uid,
    };
  }

  ClassroomEntity toEntity() {
    return ClassroomEntity(
      startTime: startTime,
      endTime: endTime,
      meetingDay: meetingDay,
      uid: uid,
    );
  }

  factory ClassroomModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return ClassroomModel(
      endTime: documentSnapshot['end_time'],
      startTime: documentSnapshot['start_time'],
      meetingDay: documentSnapshot['meeting_day'],
      uid: documentSnapshot['uid'],
    );
  }

  factory ClassroomModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return ClassroomModel(
      endTime: documentSnapshot['end_time'],
      startTime: documentSnapshot['start_time'],
      meetingDay: documentSnapshot['meeting_day'],
      uid: documentSnapshot['uid'],
    );
  }

  factory ClassroomModel.fromEntity(ClassroomEntity entity) {
    return ClassroomModel(
      startTime: entity.startTime,
      endTime: entity.endTime,
      meetingDay: entity.meetingDay,
      uid: entity.uid,
    );
  }
}
