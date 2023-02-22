import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailMeetingModel extends DetailMeetingEntity {
  const DetailMeetingModel({
    required super.assistant1Uid,
    required super.meetingDate,
    required super.assistant2Uid,
    required super.classUid,
    required super.modulPath,
    required super.topic,
    required super.uid,
  });

  Map<String, dynamic> toDocument() {
    return {
      'assistant1_uid': assistant1Uid,
      'meeting_date': meetingDate,
      'assistant2_uid': assistant2Uid,
      'classroom_uid': classUid,
      'modul_path': modulPath,
      'topic': topic,
      'uid': uid,
    };
  }

  DetailMeetingEntity toEntity() {
    return DetailMeetingEntity(
      assistant1Uid: assistant1Uid,
      meetingDate: meetingDate,
      assistant2Uid: assistant2Uid,
      classUid: classUid,
      modulPath: modulPath,
      topic: topic,
      uid: uid,
    );
  }

  factory DetailMeetingModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return DetailMeetingModel(
      assistant1Uid: documentSnapshot['assistant1_uid'],
      meetingDate: documentSnapshot['meeting_date'].toDate(),
      assistant2Uid: documentSnapshot['assistant2_uid'],
      classUid: documentSnapshot['classroom_uid'],
      modulPath: documentSnapshot['modul_path'],
      topic: documentSnapshot['topic'],
      uid: documentSnapshot['uid'],
    );
  }

  factory DetailMeetingModel.fromEntity(DetailMeetingEntity entity) {
    return DetailMeetingModel(
      assistant1Uid: entity.assistant1Uid,
      meetingDate: entity.meetingDate,
      assistant2Uid: entity.assistant2Uid,
      classUid: entity.classUid,
      modulPath: entity.modulPath,
      topic: entity.topic,
      uid: entity.uid,
    );
  }

  
}
