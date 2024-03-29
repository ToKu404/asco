import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/src/data/datasources/helpers/ds_helper.dart';
import 'package:asco/src/data/models/attendance_models/attendance_model.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';

class DetailMeetingModel extends DetailMeetingEntity {
  const DetailMeetingModel({
    required super.uid,
    required super.classUid,
    required super.assistant1Uid,
    required super.assistant2Uid,
    required super.meetingDate,
    required super.topic,
    required super.modulPath,
    required super.attendances,
    required super.meetingNumber,
    required super.maxQuizScore,
  });

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'classroom_uid': classUid,
      'assistant1_uid': assistant1Uid,
      'assistant2_uid': assistant2Uid,
      'meeting_date': meetingDate,
      'topic': topic,
      'modul_path': modulPath,
      'meeting_number': meetingNumber,
      'max_quiz_score': maxQuizScore,
      'attendances': (attendances != null)
          ? attendances!
              .map((entity) => AttendanceModel.fromEntity(entity).toDocument())
              .toList()
          : <Map<String, dynamic>>[],
    };
  }

  DetailMeetingEntity toEntity() {
    return DetailMeetingEntity(
      uid: uid,
      classUid: classUid,
      assistant1Uid: assistant1Uid,
      assistant2Uid: assistant2Uid,
      meetingDate: meetingDate,
      topic: topic,
      modulPath: modulPath,
      meetingNumber: meetingNumber,
      maxQuizScore: maxQuizScore,
      attendances: attendances,
    );
  }

  factory DetailMeetingModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return DetailMeetingModel(
      uid: documentSnapshot['uid'],
      classUid: documentSnapshot['classroom_uid'],
      assistant1Uid: documentSnapshot['assistant1_uid'],
      assistant2Uid: documentSnapshot['assistant2_uid'],
      meetingDate: (documentSnapshot['meeting_date'] as Timestamp).toDate(),
      topic: documentSnapshot['topic'],
      modulPath: documentSnapshot['modul_path'],
      meetingNumber: ReadHelper.isKeyExist(documentSnapshot, 'meeting_number')
          ? documentSnapshot['meeting_number']
          : null,
      maxQuizScore: documentSnapshot['max_quiz_score'],
      attendances: ReadHelper.isKeyExist(documentSnapshot, 'attendances')
          ? documentSnapshot['attendances']
              .map((map) => AttendanceModel.fromMap(map).toEntity())
              .toList()
              .cast<AttendanceEntity>()
          : <AttendanceEntity>[],
    );
  }

  factory DetailMeetingModel.fromEntity(DetailMeetingEntity entity) {
    return DetailMeetingModel(
      uid: entity.uid,
      classUid: entity.classUid,
      assistant1Uid: entity.assistant1Uid,
      assistant2Uid: entity.assistant2Uid,
      meetingDate: entity.meetingDate,
      topic: entity.topic,
      modulPath: entity.modulPath,
      attendances: entity.attendances,
      meetingNumber: entity.meetingNumber,
      maxQuizScore: entity.maxQuizScore,
    );
  }
}
