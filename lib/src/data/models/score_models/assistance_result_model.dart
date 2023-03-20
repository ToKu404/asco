import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/src/domain/entities/score_entities/assistance_result_entity.dart';

class AssistanceResultModel extends AssistanceResultEntity {
  const AssistanceResultModel({
    required super.uid,
    required super.meetingUid,
    required super.courseUid,
    required super.groupUid,
    required super.results,
  });

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'meeting_uid': meetingUid,
      'course_uid': courseUid,
      'group_uid': groupUid,
      'results': results,
    };
  }

  AssistanceResultEntity toEntity() {
    return AssistanceResultEntity(
      uid: uid,
      meetingUid: meetingUid,
      courseUid: courseUid,
      groupUid: groupUid,
      results: results,
    );
  }

  factory AssistanceResultModel.fromSnapshot(
      DocumentSnapshot documentSnapshot) {
    return AssistanceResultModel(
      uid: documentSnapshot['uid'],
      meetingUid: documentSnapshot['meeting_uid'],
      courseUid: documentSnapshot['course_uid'],
      groupUid: documentSnapshot['group_uid'],
      results: documentSnapshot['results'],
    );
  }

  factory AssistanceResultModel.fromEntity(AssistanceResultEntity entity) {
    return AssistanceResultModel(
      uid: entity.uid,
      meetingUid: entity.meetingUid,
      courseUid: entity.courseUid,
      groupUid: entity.groupUid,
      results: entity.results,
    );
  }
}
