import 'package:asco/src/domain/entities/score_entities/score_entity.dart';

class ScoreModel extends ScoreEntity {
  const ScoreModel({
    required super.studentId,
    required super.score,
    required super.predicate,
    required super.note,
  });

  Map<String, dynamic> toDocument() {
    return {
      'student_id': studentId,
      'score': score,
      'predicate': predicate,
      'note': note,
    };
  }

  ScoreEntity toEntity() {
    return ScoreEntity(
      studentId: studentId,
      score: score,
      predicate: predicate,
      note: note,
    );
  }

  factory ScoreModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return ScoreModel(
      studentId: documentSnapshot['student_id'],
      score: documentSnapshot['score'],
      predicate: documentSnapshot['predicate'],
      note: documentSnapshot['note'],
    );
  }

  factory ScoreModel.fromEntity(ScoreEntity entity) {
    return ScoreModel(
      studentId: entity.studentId,
      score: entity.score,
      predicate: entity.predicate,
      note: entity.note,
    );
  }
}
