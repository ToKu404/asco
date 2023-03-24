import 'package:asco/src/domain/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClassroomModel extends ClassroomEntity {
  const ClassroomModel({
    super.uid,
    super.practicum,
    super.classCode,
    super.meetingDay,
    super.startHour,
    super.endHour,
    super.startMinute,
    super.endMinute,
    super.students,
  });

  ClassroomEntity toEntity() {
    return ClassroomEntity(
      uid: uid,
      practicum: practicum,
      classCode: classCode,
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
    PracticumEntity? practicum,
  ) {
    return ClassroomModel(
      uid: documentSnapshot['uid'],
      practicum: practicum,
      classCode: documentSnapshot['class_code'],
      meetingDay: documentSnapshot['meeting_day'],
      startHour: documentSnapshot['start_hour'],
      endHour: documentSnapshot['end_hour'],
      startMinute: documentSnapshot['start_minute'],
      endMinute: documentSnapshot['end_minute'],
      students: users,
    );
  }

  factory ClassroomModel.fromMap(
    Map<String, dynamic> documentSnapshot,
    PracticumEntity? practicumEntity,
  ) {
    return ClassroomModel(
      uid: documentSnapshot['uid'],
      practicum: practicumEntity,
      classCode: documentSnapshot['class_code'],
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
      practicum: entity.practicum,
      classCode: entity.classCode,
      startHour: entity.startHour,
      endHour: entity.endHour,
      startMinute: entity.startMinute,
      endMinute: entity.endMinute,
      meetingDay: entity.meetingDay,
      students: entity.students,
    );
  }
}
