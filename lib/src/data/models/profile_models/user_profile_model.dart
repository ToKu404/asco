import 'package:asco/src/domain/entities/profile_entities/user_profile_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    super.classOff,
    super.fullName,
    super.gender,
    super.github,
    super.id,
    super.instagram,
    super.nickName,
    super.profilePhoto,
  });

  Map<String, dynamic> toDocument() {
    return {
      'class_of': classOff,
      'full_name': fullName,
      'gender': gender,
      'github': github,
      'id': id,
      'instagram': instagram,
      'nick_name': nickName,
      'profile_photo': profilePhoto,
    };
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      classOff: classOff,
      fullName: fullName,
      gender: gender,
      github: github,
      id: id,
      instagram: instagram,
      nickName: nickName,
      profilePhoto: profilePhoto,
    );
  }

  factory UserProfileModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserProfileModel(
      classOff: documentSnapshot['class_of'],
      fullName: documentSnapshot['full_name'],
      gender: documentSnapshot['gender'],
      github: documentSnapshot['github'],
      id: documentSnapshot['id'],
      instagram: documentSnapshot['instagram'],
      nickName: documentSnapshot['nick_name'],
      profilePhoto: documentSnapshot['profile_photo'],
    );
  }

  factory UserProfileModel.fromEntity(UserProfileEntity userProfileEntity) {
    return UserProfileModel(
      classOff: userProfileEntity.classOff,
      fullName: userProfileEntity.fullName,
      gender: userProfileEntity.gender,
      github: userProfileEntity.github,
      id: userProfileEntity.id,
      instagram: userProfileEntity.instagram,
      nickName: userProfileEntity.nickName,
      profilePhoto: userProfileEntity.profilePhoto,
    );
  }
}
