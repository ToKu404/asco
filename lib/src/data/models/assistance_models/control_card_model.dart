import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/src/data/models/assistance_models/assistance_attendance_model.dart';
import 'package:asco/src/domain/entities/assistance_entities/control_card_entity.dart';

class ControlCardModel extends ControlCardEntity {
  const ControlCardModel({
    super.assistance1,
    super.assistance2,
    super.meeting,
  });

  Map<String, dynamic> toDocument() {
    return {
      'assistance1': (assistance1 != null)
          ? AssistanceAttendanceModel.fromEntity(assistance1!).toDocument()
          : null,
      'assistance2': (assistance2 != null)
          ? AssistanceAttendanceModel.fromEntity(assistance2!).toDocument()
          : null,
      'meeting': null,
    };
  }

  ControlCardEntity toEntity() {
    return ControlCardEntity(
      assistance1: assistance1,
      assistance2: assistance2,
    );
  }

  factory ControlCardModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return ControlCardModel(
      assistance1:
          AssistanceAttendanceModel.fromMap(documentSnapshot['assistance1'])
              .toEntity(),
      assistance2:
          AssistanceAttendanceModel.fromMap(documentSnapshot['assistance2'])
              .toEntity(),
    );
  }

  factory ControlCardModel.fromEntity(ControlCardEntity entity) {
    return ControlCardModel(
      assistance1: entity.assistance1,
      assistance2: entity.assistance2,
    );
  }
}
