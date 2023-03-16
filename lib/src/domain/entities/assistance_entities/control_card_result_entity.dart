import 'package:equatable/equatable.dart';
import 'package:asco/src/domain/entities/assistance_entities/control_card_entity.dart';

class ControlCardResultEntity extends Equatable {
  final String? studentId;
  final List<ControlCardEntity>? controlCards;

  const ControlCardResultEntity({
    this.studentId,
    this.controlCards,
  });

  @override
  List<Object?> get props => [
        studentId,
        controlCards,
      ];
}
