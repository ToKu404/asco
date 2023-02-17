import 'package:asco/src/domain/entities/score_entities/assistance_result_entity.dart';
import 'package:asco/src/domain/entities/score_entities/exam_result_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExamResultModel extends ExamResultEntity {
  const ExamResultModel({
    required super.uid,
    required super.examUid,
    required super.results,
  });

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'exam_uid': examUid,
      'results': results,
    };
  }

  ExamResultEntity toEntity() {
    return ExamResultEntity(
      uid: uid,
      examUid: examUid,
      results: results,
    );
  }

  factory ExamResultModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return ExamResultModel(
      uid: documentSnapshot['uid'],
      examUid: documentSnapshot['exam_uid'],
      results: documentSnapshot['results'],
    );
  }

  factory ExamResultModel.fromEntity(ExamResultEntity entity) {
    return ExamResultModel(
      uid: entity.uid,
      examUid: entity.examUid,
      results: entity.results,
    );
  }
}
