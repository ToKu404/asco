import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:equatable/equatable.dart';

class ScoreEntity extends Equatable {
  final DetailProfileEntity? student;
  final double? score;
  final String? note;
  final String? predicate;

  const ScoreEntity({
    this.score,
    this.student,
    this.note,
    this.predicate,
  });

  @override
  List<Object?> get props => [
        score,
        student,
        note,
        predicate,
      ];
}
