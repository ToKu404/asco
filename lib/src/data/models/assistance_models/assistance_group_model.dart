import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_group_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';

class AssistanceGroupModel extends AssistanceGroupEntity {
  const AssistanceGroupModel({
    required super.uid,
    required super.practicumUid,
    required super.name,
    required super.assistant,
    required super.students,
  });

  AssistanceGroupEntity toEntity() {
    return AssistanceGroupEntity(
      uid: uid,
      practicumUid: practicumUid,
      name: name,
      assistant: assistant,
      students: students,
    );
  }

  factory AssistanceGroupModel.fromSnapshot(
    DocumentSnapshot documentSnapshot,
    List<ProfileEntity> students,
    ProfileEntity? assistant,
  ) {
    return AssistanceGroupModel(
      uid: documentSnapshot['uid'],
      practicumUid: documentSnapshot['practicum_uid'],
      name: documentSnapshot['name'],
      assistant: assistant,
      students: students,
    );
  }

  factory AssistanceGroupModel.fromEntity(
      AssistanceGroupEntity assistanceEntity) {
    return AssistanceGroupModel(
      uid: assistanceEntity.uid,
      practicumUid: assistanceEntity.practicumUid,
      name: assistanceEntity.name,
      assistant: assistanceEntity.assistant,
      students: assistanceEntity.students,
    );
  }

  static fromMap(Map<String, dynamic> map) {}
}
