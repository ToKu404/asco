import 'package:asco/src/data/datasources/helpers/ds_helper.dart';
import 'package:asco/src/data/models/profile_models/profile_model.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClassroomModel extends ClassroomEntity {
  const ClassroomModel({
    super.startHour,
    super.endHour,
    super.meetingDay,
    super.uid,
    super.practicumUid,
    super.endMinute,
    super.startMinute,
    super.classCode,
    super.courseName,
    super.students,
  });

  Map<String, dynamic> toDocument() {
    return {
      "start_hour": startHour,
      "end_hour": endHour,
      "start_minute": startMinute,
      "end_minute": endMinute,
      "meeting_day": meetingDay,
      "uid": uid,
      "practicum_uid": practicumUid,
      "class_code": classCode,
      "course_name": courseName,
      "students": students != null
          ? students!
              .map((e) => ProfileModel.fromEntity(e).toDocument())
              .toList()
          : [],
    };
  }

  ClassroomEntity toEntity() {
    return ClassroomEntity(
      startHour: startHour,
      endHour: endHour,
      meetingDay: meetingDay,
      uid: uid,
      startMinute: startMinute,
      endMinute: endMinute,
      practicumUid: practicumUid,
      classCode: classCode,
      courseName: courseName,
      students: students,
    );
  }

  factory ClassroomModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return ClassroomModel(
      endHour: documentSnapshot['end_hour'],
      endMinute: documentSnapshot['end_minute'],
      startHour: documentSnapshot['start_hour'],
      startMinute: documentSnapshot['start_minute'],
      meetingDay: documentSnapshot['meeting_day'],
      uid: documentSnapshot['uid'],
      classCode: documentSnapshot['class_code'],
      practicumUid: documentSnapshot['practicum_uid'],
      courseName: documentSnapshot['course_name'],
      students: ReadHelper.isKeyExist(documentSnapshot, 'students')
          ? List<ProfileEntity>.from(
              documentSnapshot.get('students').map(
                    (e) => ProfileModel.fromMap(e).toEntity(),
                  ),
            )
          : [],
    );
  }

  factory ClassroomModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return ClassroomModel(
      endHour: documentSnapshot['end_hour'],
      endMinute: documentSnapshot['end_minute'],
      startHour: documentSnapshot['start_hour'],
      startMinute: documentSnapshot['start_minute'],
      meetingDay: documentSnapshot['meeting_day'],
      uid: documentSnapshot['uid'],
      practicumUid: documentSnapshot['practicum_uid'],
      classCode: documentSnapshot['class_code'],
      courseName: documentSnapshot['course_name'],
      students: List<ProfileEntity>.from(
        documentSnapshot['students'].map(
          (e) => ProfileModel.fromMap(e).toEntity(),
        ),
      ),
    );
  }

  factory ClassroomModel.fromEntity(ClassroomEntity entity) {
    return ClassroomModel(
      startHour: entity.startHour,
      endHour: entity.endHour,
      startMinute: entity.startMinute,
      endMinute: entity.endMinute,
      meetingDay: entity.meetingDay,
      uid: entity.uid,
      practicumUid: entity.practicumUid,
      classCode: entity.classCode,
      courseName: entity.courseName,
      students: entity.students,
    );
  }
}
