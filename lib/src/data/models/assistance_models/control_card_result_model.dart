import 'package:asco/src/domain/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'control_card_model.dart';

class ControlCardResultModel extends ControlCardResultEntity {
  const ControlCardResultModel({
    super.student,
    super.data,
    super.practicumUid,
    super.uid,
  });

  Map<String, dynamic> toDocument() {
    return {};
  }

  ControlCardResultEntity toEntity() {
    return ControlCardResultEntity(
      data: data,
      student: student,
      practicumUid: practicumUid,
      uid: uid,
    );
  }

  factory ControlCardResultModel.fromSnapshot(
    DocumentSnapshot documentSnapshot,
    List<ControlCardEntity> data,
    ProfileEntity? student,
  ) {
    return ControlCardResultModel(
      data: data,
      student: student,
      practicumUid: documentSnapshot['practicum_uid'],
      uid: documentSnapshot['uid'],
    );
  }

  factory ControlCardResultModel.fromEntity(ControlCardResultEntity entity) {
    return ControlCardResultModel(
      data: entity.data,
      student: entity.student,
      practicumUid: entity.practicumUid,
      uid: entity.uid,
    );
  }
}
