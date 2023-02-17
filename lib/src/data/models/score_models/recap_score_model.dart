import 'package:asco/src/domain/entities/score_entities/assistance_result_entity.dart';
import 'package:asco/src/domain/entities/score_entities/exam_result_entity.dart';
import 'package:asco/src/domain/entities/score_entities/recap_score_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecapScoreModel extends RecapScoreEntity {
  const RecapScoreModel({
    required super.uid,
    required super.practicumUid,
    required super.results,
  });

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'practicum_uid': practicumUid,
      'results': results,
    };
  }

  RecapScoreEntity toEntity() {
    return RecapScoreEntity(
      uid: uid,
      practicumUid: practicumUid,
      results: results,
    );
  }

  factory RecapScoreModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return RecapScoreModel(
      uid: documentSnapshot['uid'],
      practicumUid: documentSnapshot['practicum_uid'],
      results: documentSnapshot['results'],
    );
  }

  factory RecapScoreModel.fromEntity(RecapScoreEntity entity) {
    return RecapScoreModel(
      uid: entity.uid,
      practicumUid: entity.practicumUid,
      results: entity.results,
    );
  }
}
