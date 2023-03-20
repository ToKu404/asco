import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/src/domain/entities/score_entities/quiz_result_entity.dart';

class QuizResultModel extends QuizResultEntity {
  const QuizResultModel({
    required super.uid,
    required super.meetingUid,
    required super.courseUid,
    required super.maxPoint,
    required super.results,
  });

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'meeting_uid': meetingUid,
      'course_uid': courseUid,
      'max_point': maxPoint,
      'results': results,
    };
  }

  QuizResultEntity toEntity() {
    return QuizResultEntity(
      uid: uid,
      meetingUid: meetingUid,
      courseUid: courseUid,
      maxPoint: maxPoint,
      results: results,
    );
  }

  factory QuizResultModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return QuizResultModel(
      uid: documentSnapshot['uid'],
      meetingUid: documentSnapshot['meeting_uid'],
      courseUid: documentSnapshot['course_uid'],
      maxPoint: documentSnapshot['max_point'],
      results: documentSnapshot['results'],
    );
  }

  factory QuizResultModel.fromEntity(QuizResultEntity entity) {
    return QuizResultModel(
      uid: entity.uid,
      meetingUid: entity.meetingUid,
      courseUid: entity.courseUid,
      maxPoint: entity.maxPoint,
      results: entity.results,
    );
  }
}
