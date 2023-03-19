import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/src/domain/entities/profile_entities/user_practicum_entity.dart';

class UserPracticumModel extends UserPracticumEntity {
  const UserPracticumModel({super.classroom, super.group});

  Map<String, dynamic> toDocument() {
    return {
      'classroom': classroom,
      'group': group,
    };
  }

  UserPracticumEntity toEntity() {
    return UserPracticumEntity(
      classroom: classroom,
      group: group,
    );
  }

  factory UserPracticumModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserPracticumModel(
      classroom: documentSnapshot['classroom'],
      group: documentSnapshot['group'],
    );
  }

  factory UserPracticumModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return UserPracticumModel(
      classroom: documentSnapshot['classroom'],
      group: documentSnapshot['group'],
    );
  }

  factory UserPracticumModel.fromEntity(UserPracticumEntity userProfileEntity) {
    return UserPracticumModel(
      classroom: userProfileEntity.classroom,
      group: userProfileEntity.group,
    );
  }
}
