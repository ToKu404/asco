import 'package:asco/src/domain/entities/profile_entities/user_practicum_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserPracticumModel extends UserPracticumEntity {
  const UserPracticumModel({
    super.group,
    super.classroom,
  });

  Map<String, dynamic> toDocument() {
    return {
      'group': group,
      'classroom': classroom,
    };
  }

  UserPracticumEntity toEntity() {
    return UserPracticumEntity(
      group: group,
      classroom: classroom,
    );
  }

  factory UserPracticumModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserPracticumModel(
      group: documentSnapshot['group'],
      classroom: documentSnapshot['classroom'],
    );
  }

  factory UserPracticumModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return UserPracticumModel(
      group: documentSnapshot['group'],
      classroom: documentSnapshot['classroom'],
    );
  }

  factory UserPracticumModel.fromEntity(UserPracticumEntity userProfileEntity) {
    return UserPracticumModel(
      group: userProfileEntity.group,
      classroom: userProfileEntity.classroom,
    );
  }
}
