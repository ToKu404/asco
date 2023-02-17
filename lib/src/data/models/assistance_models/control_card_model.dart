import 'package:asco/src/domain/entities/assistance_entities/control_card_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ControlCardModel extends ControlCardEntity {
  const ControlCardModel({
    required super.assistance1,
    required super.assistance2,
    required super.meetingUid,
    required super.student,
    required super.uid,
  });

  Map<String, dynamic> toDocument() {
    return {
      'assistance1': assistance1,
      'assistance2': assistance2,
      'meeting_uid': meetingUid,
      'student': student,
      'uid': uid,
    };
  }

  ControlCardEntity toEntity() {
    return ControlCardEntity(
      assistance1: assistance1,
      assistance2: assistance2,
      meetingUid: meetingUid,
      student: student,
      uid: uid,
    );
  }

  factory ControlCardModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return ControlCardModel(
      assistance1: documentSnapshot['assistance1'],
      assistance2: documentSnapshot['assistance2'],
      meetingUid: documentSnapshot['meeting_uid'],
      student: documentSnapshot['student'],
      uid: documentSnapshot['uid'],
    );
  }

  factory ControlCardModel.fromEntity(ControlCardEntity entity) {
    return ControlCardModel(
      assistance1: entity.assistance1,
      assistance2: entity.assistance2,
      meetingUid: entity.meetingUid,
      student: entity.student,
      uid: entity.uid,
    );
  }
}
