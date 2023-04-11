import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/src/data/models/meeting_models/detail_meeting_model.dart';
import 'package:asco/src/domain/entities/meeting_entities/meeting_entity.dart';

class MeetingModel extends MeetingEntity {
  const MeetingModel({
    required super.uid,
    required super.topic,
    required super.meetingDate,
    required super.meetingNumber,
  });

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'topic': topic,
      'meeting_date': meetingDate,
      'meeting_number': meetingNumber,
    };
  }

  MeetingEntity toEntity() {
    return MeetingEntity(
      uid: uid,
      topic: topic,
      meetingDate: meetingDate,
      meetingNumber: meetingNumber,
    );
  }

  factory MeetingModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return MeetingModel(
      uid: documentSnapshot['uid'],
      topic: documentSnapshot['topic'],
      meetingNumber: documentSnapshot['meeting_number'],
      meetingDate: (documentSnapshot['meeting_date'] as Timestamp).toDate(),
    );
  }

  factory MeetingModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return MeetingModel(
      uid: documentSnapshot['uid'],
      topic: documentSnapshot['topic'],
      meetingNumber: documentSnapshot['meeting_number'],
      meetingDate: (documentSnapshot['meeting_date'] as Timestamp).toDate(),
    );
  }

  factory MeetingModel.fromEntity(MeetingEntity entity) {
    return MeetingModel(
      uid: entity.uid,
      topic: entity.topic,
      meetingDate: entity.meetingDate,
      meetingNumber: entity.meetingNumber,
    );
  }

  factory MeetingModel.fromDetail(DetailMeetingModel model) {
    return MeetingModel(
      uid: model.uid,
      topic: model.topic,
      meetingDate: model.meetingDate,
      meetingNumber: model.meetingNumber,
    );
  }
}
