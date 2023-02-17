import 'package:asco/src/domain/entities/meeting_entities/meeting_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MeetingModel extends MeetingEntity {
  const MeetingModel({
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
      'class_uid': classUid,
      'modul_path': modulPath,
      'topic': topic,
      'uid': uid,
    };
  }

  MeetingEntity toEntity() {
    return MeetingEntity(
      assistant1: assistant1,
      meetingDate: meetingDate,
      assistant2: assistant2,
      classUid: classUid,
      modulPath: modulPath,
      topic: topic,
      uid: uid,
    );
  }

  factory MeetingModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return MeetingModel(
      assistant1: documentSnapshot['assistant1'],
      meetingDate: documentSnapshot['meeting_date'],
      assistant2: documentSnapshot['assistant2'],
      classUid: documentSnapshot['class_uid'],
      modulPath: documentSnapshot['modul_path'],
      topic: documentSnapshot['topic'],
      uid: documentSnapshot['uid'],
    );
  }

  factory MeetingModel.fromEntity(MeetingEntity entity) {
    return MeetingModel(
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
