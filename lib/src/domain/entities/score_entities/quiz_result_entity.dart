import 'package:equatable/equatable.dart';
import 'package:asco/src/domain/entities/score_entities/score_entity.dart';

class QuizResultEntity extends Equatable {
  final String? uid;
  final String? meetingUid;
  final String? courseUid;
  final int? maxPoint;
  final List<ScoreEntity>? results;

  const QuizResultEntity({
    this.uid,
    this.meetingUid,
    this.courseUid,
    this.maxPoint,
    this.results,
  });

  @override
  List<Object?> get props => [
        uid,
        meetingUid,
        courseUid,
        maxPoint,
        results,
      ];
}
