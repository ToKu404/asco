// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class ScoreEntity extends Equatable {
  final double? quizScore;
  final double? assistanceScore;
  final double? midScore;
  final double? examScore;
  double? recapScore;
  String? predicate;
  final String studentId;

  ScoreEntity({
    this.assistanceScore,
    this.quizScore,
    this.examScore,
    this.midScore,
    this.predicate,
    this.recapScore,
    required this.studentId,
  });

  @override
  List<Object?> get props => [
        assistanceScore,
        quizScore,
        examScore,
        midScore,
        recapScore,
        predicate,
        studentId,
      ];
}
