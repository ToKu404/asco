import 'package:asco/src/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';

class ControlCardResultEntity extends Equatable {
  final ProfileEntity? student;
  final String? practicumUid;
  final List<ControlCardEntity>? controlCards;

  const ControlCardResultEntity({
    this.student,
    this.controlCards,
    this.practicumUid,
  });

  @override
  List<Object?> get props => [
        student,
        controlCards,
        practicumUid,
      ];
}
