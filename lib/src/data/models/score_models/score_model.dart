import 'package:asco/src/domain/entities/score_entities/score_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ScoreModel extends ScoreEntity {
  ScoreModel({
    super.assistanceScore,
    super.examScore,
    super.midScore,
    super.predicate,
    super.quizScore,
    super.recapScore,
    required super.studentId,
  });

  Map<String, dynamic> toDocument() {
    return {
      'assistanceScore': assistanceScore,
      'examScore': examScore,
      'midScore': midScore,
      'quizScore': quizScore,
      'recapScore': recapScore,
      'predicate': predicate,
      'studentId': studentId,
    };
  }

  ScoreEntity toEntity() {
    return ScoreEntity(
      assistanceScore: assistanceScore,
      examScore: examScore,
      midScore: midScore,
      predicate: predicate,
      quizScore: quizScore,
      recapScore: recapScore,
      studentId: studentId,
    );
  }

  factory ScoreModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return ScoreModel(
      assistanceScore: documentSnapshot['assistanceScore'],
      examScore: documentSnapshot['examScore'],
      midScore: documentSnapshot['midScore'],
      predicate: documentSnapshot['predicate'],
      quizScore: documentSnapshot['quizScore'],
      recapScore: documentSnapshot['recapScore'],
      studentId: documentSnapshot['studentId'],
    );
  }
  factory ScoreModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return ScoreModel(
      assistanceScore: documentSnapshot['assistanceScore'],
      examScore: documentSnapshot['examScore'],
      midScore: documentSnapshot['midScore'],
      predicate: documentSnapshot['predicate'],
      quizScore: documentSnapshot['quizScore'],
      recapScore: documentSnapshot['recapScore'],
      studentId: documentSnapshot['studentId'],
    );
  }

  factory ScoreModel.fromEntity(ScoreEntity entity) {
    return ScoreModel(
      assistanceScore: entity.assistanceScore,
      examScore: entity.examScore,
      midScore: entity.midScore,
      predicate: entity.predicate,
      quizScore: entity.quizScore,
      recapScore: entity.recapScore,
      studentId: entity.studentId,
    );
  }
}
