import 'package:equatable/equatable.dart';

class ScoreEntity extends Equatable {
  final String? studentId;
  final double? score;
  final String? predicate;
  final String? note;

  const ScoreEntity({
    this.studentId,
    this.score,
    this.predicate,
    this.note,
  });

  @override
  List<Object?> get props => [
        studentId,
        score,
        predicate,
        note,
      ];
}
