import 'package:asco/src/domain/entities/score_entities/quiz_result_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizResultModel extends QuizResultEntity {
  const QuizResultModel({
    required super.uid,
    required super.courseUid,
    required super.maxPoint,
    required super.meetingUid,
    required super.results,
  });

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'course_uid': courseUid,
      'max_point': maxPoint,
      'meeting_uid': meetingUid,
      'results': results,
    };
  }

  QuizResultEntity toEntity() {
    return QuizResultEntity(
      uid: uid,
      courseUid: courseUid,
      maxPoint: maxPoint,
      meetingUid: meetingUid,
      results: results,
    );
  }

  factory QuizResultModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return QuizResultModel(
      uid: documentSnapshot['uid'],
      courseUid: documentSnapshot['course_uid'],
      maxPoint: documentSnapshot['max_point'],
      meetingUid: documentSnapshot['meeting_uid'],
      results: documentSnapshot['results'],
    );
  }

  factory QuizResultModel.fromEntity(QuizResultEntity entity) {
    return QuizResultModel(
      uid: entity.uid,
      courseUid: entity.courseUid,
      maxPoint: entity.maxPoint,
      meetingUid: entity.meetingUid,
      results: entity.results,
    );
  }
}
