import 'package:asco/src/domain/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ControlCardResultModel extends ControlCardResultEntity {
  const ControlCardResultModel({
    required super.student,
    required super.controlCards,
    required super.practicumUid,
  });

  Map<String, dynamic> toDocument() {
    return {};
  }

  ControlCardResultEntity toEntity() {
    return ControlCardResultEntity(
      controlCards: controlCards,
      student: student,
    );
  }

  factory ControlCardResultModel.fromSnapshot(
      DocumentSnapshot documentSnapshot) {
    return ControlCardResultModel(
      controlCards: null,
      student: null,
      practicumUid: null,
    );
  }

  factory ControlCardResultModel.fromEntity(ControlCardResultEntity entity) {
    return ControlCardResultModel(
      controlCards: entity.controlCards,
      student: entity.student,
      practicumUid: entity.practicumUid,
    );
  }
}
