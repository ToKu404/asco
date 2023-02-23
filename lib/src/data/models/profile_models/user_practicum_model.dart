import 'package:asco/src/domain/entities/profile_entities/user_practicum_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserPracticumModel extends UserPracticumEntity {
  const UserPracticumModel({
    super.assistanceGroupUid,
    super.classUid,
  });

  Map<String, dynamic> toDocument() {
    return {
      'assistance_group_uid': assistanceGroupUid,
      'class_uid': classUid,
    };
  }

  UserPracticumEntity toEntity() {
    return UserPracticumEntity(
      assistanceGroupUid: assistanceGroupUid,
      classUid: classUid,
    );
  }

  factory UserPracticumModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserPracticumModel(
      assistanceGroupUid: documentSnapshot['assistance_group_uid'],
      classUid: documentSnapshot['class_uid'],
    );
  }

  factory UserPracticumModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return UserPracticumModel(
      assistanceGroupUid: documentSnapshot['assistance_group_uid'],
      classUid: documentSnapshot['class_uid'],
    );
  }

  factory UserPracticumModel.fromEntity(UserPracticumEntity userProfileEntity) {
    return UserPracticumModel(
      assistanceGroupUid: userProfileEntity.assistanceGroupUid,
      classUid: userProfileEntity.classUid,
    );
  }
}
