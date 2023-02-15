import 'package:asco/src/domain/entities/profile_entities/user_profile_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    super.classOff,
    super.fullName,
    super.gender,
    super.github,
    super.username,
    super.instagram,
    super.nickName,
    super.profilePhoto,
    super.uid,
  });

  Map<String, dynamic> toDocument() {
    return {
      'class_of': classOff,
      'full_name': fullName,
      'gender': gender,
      'github': github,
      'username': username,
      'instagram': instagram,
      'nick_name': nickName,
      'profile_photo': profilePhoto,
      'uid': uid,
    };
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      classOff: classOff,
      fullName: fullName,
      gender: gender,
      github: github,
      username: username,
      instagram: instagram,
      nickName: nickName,
      profilePhoto: profilePhoto,
      uid: uid,
    );
  }

  factory UserProfileModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserProfileModel(
      classOff: documentSnapshot['class_of'],
      fullName: documentSnapshot['full_name'],
      gender: documentSnapshot['gender'],
      github: documentSnapshot['github'],
      username: documentSnapshot['username'],
      instagram: documentSnapshot['instagram'],
      nickName: documentSnapshot['nick_name'],
      profilePhoto: documentSnapshot['profile_photo'],
      uid: documentSnapshot['uid'],
    );
  }

  factory UserProfileModel.fromEntity(UserProfileEntity userProfileEntity) {
    return UserProfileModel(
      classOff: userProfileEntity.classOff,
      fullName: userProfileEntity.fullName,
      gender: userProfileEntity.gender,
      github: userProfileEntity.github,
      username: userProfileEntity.username,
      instagram: userProfileEntity.instagram,
      nickName: userProfileEntity.nickName,
      profilePhoto: userProfileEntity.profilePhoto,
      uid: userProfileEntity.uid,
    );
  }
}
