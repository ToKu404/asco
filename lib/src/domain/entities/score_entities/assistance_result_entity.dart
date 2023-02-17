import 'package:asco/src/domain/entities/score_entities/score_entity.dart';
import 'package:equatable/equatable.dart';

class AssistanceResultEntity extends Equatable {
  final String? uid;
  final String? meetingUid;
  final String? courseUid;
  final String? groupUid;
  final List<ScoreEntity>? results;

  const AssistanceResultEntity({
    this.uid,
    this.courseUid,
    this.groupUid,
    this.meetingUid,
    this.results,
  });

  @override
  List<Object?> get props => [
        courseUid,
        uid,
        meetingUid,
        groupUid,
        results,
      ];
}
