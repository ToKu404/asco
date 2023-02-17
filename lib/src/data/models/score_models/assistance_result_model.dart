import 'package:asco/src/domain/entities/score_entities/assistance_result_entity.dart';
import 'package:asco/src/domain/entities/score_entities/score_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssistanceResultModel extends AssistanceResultEntity {
  const AssistanceResultModel({
    required super.uid,
    required super.courseUid,
    required super.groupUid,
    required super.meetingUid,
    required super.results,
  });

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'course_uid': courseUid,
      'group_uid': groupUid,
      'meeting_uid': meetingUid,
      'results': results,
    };
  }

  AssistanceResultEntity toEntity() {
    return AssistanceResultEntity(
      uid: uid,
      courseUid: courseUid,
      groupUid: groupUid,
      meetingUid: meetingUid,
      results: results,
    );
  }

  factory AssistanceResultModel.fromSnapshot(
      DocumentSnapshot documentSnapshot) {
    return AssistanceResultModel(
      uid: documentSnapshot['uid'],
      courseUid: documentSnapshot['course_uid'],
      groupUid: documentSnapshot['group_uid'],
      meetingUid: documentSnapshot['meeting_uid'],
      results: documentSnapshot['results'],
    );
  }

  factory AssistanceResultModel.fromEntity(AssistanceResultEntity entity) {
    return AssistanceResultModel(
      uid: entity.uid,
      courseUid: entity.courseUid,
      groupUid: entity.groupUid,
      meetingUid: entity.meetingUid,
      results: entity.results,
    );
  }
}
