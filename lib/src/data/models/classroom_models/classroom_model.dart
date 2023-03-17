import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';

class ClassroomModel extends ClassroomEntity {
  const ClassroomModel({
    super.uid,
    super.practicumUid,
    super.classCode,
    super.courseName,
    super.meetingDay,
    super.startHour,
    super.endHour,
    super.startMinute,
    super.endMinute,
    super.students,
  });

  Map<String, dynamic> toDocument() {
    return {
      "uid": uid,
      "practicum_uid": practicumUid,
      "class_code": classCode,
      "course_name": courseName,
      "meeting_day": meetingDay,
      "start_hour": startHour,
      "end_hour": endHour,
      "start_minute": startMinute,
      "end_minute": endMinute,
    };
  }

  ClassroomEntity toEntity() {
    return ClassroomEntity(
      uid: uid,
      practicumUid: practicumUid,
      classCode: classCode,
      courseName: courseName,
      meetingDay: meetingDay,
      startHour: startHour,
      endHour: endHour,
      startMinute: startMinute,
      endMinute: endMinute,
      students: students,
    );
  }

  factory ClassroomModel.fromSnapshot(
    DocumentSnapshot documentSnapshot,
    List<ProfileEntity> users,
  ) {
    return ClassroomModel(
      uid: documentSnapshot['uid'],
      practicumUid: documentSnapshot['practicum_uid'],
      classCode: documentSnapshot['class_code'],
      courseName: documentSnapshot['course_name'],
      meetingDay: documentSnapshot['meeting_day'],
      startHour: documentSnapshot['start_hour'],
      endHour: documentSnapshot['end_hour'],
      startMinute: documentSnapshot['start_minute'],
      endMinute: documentSnapshot['end_minute'],
      students: users,
    );
  }

  factory ClassroomModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return ClassroomModel(
      uid: documentSnapshot['uid'],
      practicumUid: documentSnapshot['practicum_uid'],
      classCode: documentSnapshot['class_code'],
      courseName: documentSnapshot['course_name'],
      meetingDay: documentSnapshot['meeting_day'],
      startHour: documentSnapshot['start_hour'],
      endHour: documentSnapshot['end_hour'],
      startMinute: documentSnapshot['start_minute'],
      endMinute: documentSnapshot['end_minute'],
    );
  }

  factory ClassroomModel.fromEntity(ClassroomEntity entity) {
    return ClassroomModel(
      uid: entity.uid,
      practicumUid: entity.practicumUid,
      classCode: entity.classCode,
      courseName: entity.courseName,
      startHour: entity.startHour,
      endHour: entity.endHour,
      startMinute: entity.startMinute,
      endMinute: entity.endMinute,
      meetingDay: entity.meetingDay,
      students: entity.students,
    );
  }
}
