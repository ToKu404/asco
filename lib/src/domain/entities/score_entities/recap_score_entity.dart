import 'package:equatable/equatable.dart';
import 'package:asco/src/domain/entities/score_entities/score_entity.dart';

class RecapScoreEntity extends Equatable {
  final String? uid;
  final String? practicumUid;
  final List<ScoreEntity>? results;

  const RecapScoreEntity({
    this.uid,
    this.practicumUid,
    this.results,
  });

  @override
  List<Object?> get props => [
        uid,
        practicumUid,
        results,
      ];
}
