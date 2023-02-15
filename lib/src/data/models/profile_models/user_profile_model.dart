import 'package:asco/src/data/models/profile_models/user_role_model.dart';
import 'package:asco/src/domain/entities/profile_entities/user_profile_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    super.classOf,
    super.fullName,
    super.gender,
    super.github,
    super.username,
    super.instagram,
    super.nickName,
    super.profilePhoto,
    super.uid,
    super.userRole,
  });

  Map<String, dynamic> toDocument() {
    return {
      'class_of': classOf,
      'full_name': fullName,
      'gender': gender,
      'github': github,
      'username': username,
      'instagram': instagram,
      'nick_name': nickName,
      'profile_photo': profilePhoto,
      'uid': uid,
      if (userRole != null)
        'role': {
          'id': userRole!.id,
          'name': userRole!.name,
        }
    };
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      classOf: classOf,
      fullName: fullName,
      gender: gender,
      github: github,
      username: username,
      instagram: instagram,
      nickName: nickName,
      profilePhoto: profilePhoto,
      uid: uid,
      userRole: userRole,
    );
  }

  factory UserProfileModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserProfileModel(
      classOf: documentSnapshot['class_of'],
      fullName: documentSnapshot['full_name'],
      gender: documentSnapshot['gender'],
      github: documentSnapshot['github'],
      username: documentSnapshot['username'],
      instagram: documentSnapshot['instagram'],
      nickName: documentSnapshot['nick_name'],
      profilePhoto: documentSnapshot['profile_photo'],
      uid: documentSnapshot['uid'],
      userRole: UserRoleModel.fromMap(
        documentSnapshot.get('role'),
      ),
    );
  }

  factory UserProfileModel.fromEntity(UserProfileEntity userProfileEntity) {
    return UserProfileModel(
      classOf: userProfileEntity.classOf,
      fullName: userProfileEntity.fullName,
      gender: userProfileEntity.gender,
      github: userProfileEntity.github,
      username: userProfileEntity.username,
      instagram: userProfileEntity.instagram,
      nickName: userProfileEntity.nickName,
      profilePhoto: userProfileEntity.profilePhoto,
      uid: userProfileEntity.uid,
      userRole: userProfileEntity.userRole,
    );
  }
}
