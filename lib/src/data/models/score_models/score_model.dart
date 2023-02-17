import 'package:asco/src/domain/entities/score_entities/score_entity.dart';

class ScoreModel extends ScoreEntity {
  const ScoreModel({
    required super.score,
    required super.student,
    required super.note,
    required super.predicate,
  });

  Map<String, dynamic> toDocument() {
    return {
      'score': score,
      'student': student,
      'note': note,
      'predicate': predicate,
    };
  }

  ScoreEntity toEntity() {
    return ScoreEntity(
      score: score,
      student: student,
      note: note,
      predicate: predicate,
    );
  }

  factory ScoreModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return ScoreModel(
      score: documentSnapshot['score'],
      student: documentSnapshot['student'],
      note: documentSnapshot['note'],
      predicate: documentSnapshot['predicate'],
    );
  }

  factory ScoreModel.fromEntity(ScoreEntity entity) {
    return ScoreModel(
      score: entity.score,
      student: entity.student,
      note: entity.note,
      predicate: entity.predicate,
    );
  }
}
