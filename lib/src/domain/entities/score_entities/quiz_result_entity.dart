import 'package:asco/src/domain/entities/score_entities/score_entity.dart';
import 'package:equatable/equatable.dart';

class QuizResultEntity extends Equatable {
  final String? uid;
  final String? meetingUid;
  final String? courseUid;
  final int? maxPoint;
  final List<ScoreEntity>? results;

  const QuizResultEntity({
    this.uid,
    this.courseUid,
    this.maxPoint,
    this.meetingUid,
    this.results,
  });

  @override
  List<Object?> get props => [
        courseUid,
        uid,
        meetingUid,
        maxPoint,
        results,
      ];
}
