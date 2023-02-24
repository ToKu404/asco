import 'package:asco/src/domain/entities/assistance_entities/assistance_attendance_entity.dart';
import 'package:asco/src/domain/entities/assistance_entities/control_card_entity.dart';
import 'package:equatable/equatable.dart';

class ControlCardResultEntity extends Equatable {
  final String? studentId;
  final List<ControlCardEntity>? controlCards;

  const ControlCardResultEntity({
    this.controlCards,
    this.studentId,
  });

  @override
  List<Object?> get props => [
        controlCards,
        studentId,
      ];
}
