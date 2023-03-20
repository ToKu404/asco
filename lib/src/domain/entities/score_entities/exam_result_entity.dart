import 'package:equatable/equatable.dart';
import 'package:asco/src/domain/entities/score_entities/score_entity.dart';

class ExamResultEntity extends Equatable {
  final String? uid;
  final String? examUid;
  final List<ScoreEntity>? results;

  const ExamResultEntity({
    this.uid,
    this.examUid,
    this.results,
  });

  @override
  List<Object?> get props => [
        uid,
        examUid,
        results,
      ];
}
