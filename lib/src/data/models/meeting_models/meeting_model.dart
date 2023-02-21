import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:asco/src/domain/entities/meeting_entities/meeting_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MeetingModel extends MeetingEntity {
  const MeetingModel({
    required super.meetingDate,
    required super.topic,
    required super.uid,
  });

  Map<String, dynamic> toDocument() {
    return {
      'meeting_date': meetingDate,
      'topic': topic,
      'uid': uid,
    };
  }

  MeetingEntity toEntity() {
    return MeetingEntity(
      meetingDate: meetingDate,
      topic: topic,
      uid: uid,
    );
  }

  factory MeetingModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return MeetingModel(
      meetingDate: documentSnapshot['meeting_date'],
      topic: documentSnapshot['topic'],
      uid: documentSnapshot['uid'],
    );
  }

  factory MeetingModel.fromEntity(MeetingEntity entity) {
    return MeetingModel(
      meetingDate: entity.meetingDate,
      topic: entity.topic,
      uid: entity.uid,
    );
  }
}
