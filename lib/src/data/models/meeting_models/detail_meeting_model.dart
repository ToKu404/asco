import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailMeetingModel extends DetailMeetingEntity {
  const DetailMeetingModel({
    required super.assistant1,
    required super.meetingDate,
    required super.assistant2,
    required super.classUid,
    required super.modulPath,
    required super.topic,
    required super.uid,
  });

  Map<String, dynamic> toDocument() {
    return {
      'assistant1': assistant1,
      'meeting_date': meetingDate,
      'assistant2': assistant2,
      'classroom_uid': classUid,
      'modul_path': modulPath,
      'topic': topic,
      'uid': uid,
    };
  }

  DetailMeetingEntity toEntity() {
    return DetailMeetingEntity(
      assistant1: assistant1,
      meetingDate: meetingDate,
      assistant2: assistant2,
      classUid: classUid,
      modulPath: modulPath,
      topic: topic,
      uid: uid,
    );
  }

  factory DetailMeetingModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return DetailMeetingModel(
      assistant1: documentSnapshot['assistant1'],
      meetingDate: documentSnapshot['meeting_date'],
      assistant2: documentSnapshot['assistant2'],
      classUid: documentSnapshot['classroom_uid'],
      modulPath: documentSnapshot['modul_path'],
      topic: documentSnapshot['topic'],
      uid: documentSnapshot['uid'],
    );
  }

  factory DetailMeetingModel.fromEntity(DetailMeetingEntity entity) {
    return DetailMeetingModel(
      assistant1: entity.assistant1,
      meetingDate: entity.meetingDate,
      assistant2: entity.assistant2,
      classUid: entity.classUid,
      modulPath: entity.modulPath,
      topic: entity.topic,
      uid: entity.uid,
    );
  }
}