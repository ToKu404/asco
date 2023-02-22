import 'package:equatable/equatable.dart';

class ScoreEntity extends Equatable {
  final String? studentId;
  final double? score;
  final String? note;
  final String? predicate;

  const ScoreEntity({
    this.score,
    this.studentId,
    this.note,
    this.predicate,
  });

  @override
  List<Object?> get props => [
        score,
        studentId,
        note,
        predicate,
      ];
}
