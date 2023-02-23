import 'package:asco/src/data/datasources/helpers/ds_helper.dart';
import 'package:asco/src/data/models/profile_models/profile_model.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssistanceGroupModel extends AssistanceGroupEntity {
  const AssistanceGroupModel({
    required super.assistant,
    required super.name,
    required super.practicumUid,
    required super.students,
    required super.uid,
  });

  Map<String, dynamic> toDocument() {
    return {
      "assistant": ProfileModel.fromEntity(assistant!).toDocument(),
      "name": name,
      "practicum_uid": practicumUid,
      "students": students != null
          ? students!
              .map((e) => ProfileModel.fromEntity(e).toDocument())
              .toList()
          : [],
      "uid": uid,
    };
  }

  AssistanceGroupEntity toEntity() {
    return AssistanceGroupEntity(
        assistant: assistant,
        name: name,
        practicumUid: practicumUid,
        students: students,
        uid: uid);
  }

  factory AssistanceGroupModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return AssistanceGroupModel(
      assistant: ProfileModel.fromMap(documentSnapshot['assistant']).toEntity(),
      name: documentSnapshot['name'],
      practicumUid: documentSnapshot['practicum_uid'],
      students: ReadHelper.isKeyExist(documentSnapshot, 'students')
          ? List<ProfileEntity>.from(
              documentSnapshot.get('students').map(
                    (e) => ProfileModel.fromMap(e).toEntity(),
                  ),
            )
          : [],
      uid: documentSnapshot['uid'],
    );
  }

  factory AssistanceGroupModel.fromEntity(
      AssistanceGroupEntity assistanceEntity) {
    return AssistanceGroupModel(
      assistant: assistanceEntity.assistant,
      name: assistanceEntity.name,
      practicumUid: assistanceEntity.practicumUid,
      students: assistanceEntity.students,
      uid: assistanceEntity.uid,
    );
  }
}
