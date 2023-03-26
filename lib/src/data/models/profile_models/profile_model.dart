import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/src/data/models/profile_models/user_role_model.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    super.uid,
    super.username,
    super.fullName,
    super.nickName,
    super.profilePhoto,
    super.userRole,
  });

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'username': username,
      'full_name': fullName,
      'nick_name': nickName,
      'profile_photo': profilePhoto,
      if (userRole != null)
        'role': {
          'id': userRole!.id,
          'name': userRole!.name,
        }
    };
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      uid: uid,
      username: username,
      fullName: fullName,
      profilePhoto: profilePhoto,
      userRole: userRole,
      nickName: nickName,
    );
  }

  factory ProfileModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return ProfileModel(
      uid: documentSnapshot['uid'],
      username: documentSnapshot['username'],
      fullName: documentSnapshot['full_name'],
      nickName: documentSnapshot['nick_name'],
      profilePhoto: documentSnapshot['profile_photo'],
      userRole: UserRoleModel.fromMap(documentSnapshot.get('role')),
    );
  }

  factory ProfileModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return ProfileModel(
      uid: documentSnapshot['uid'],
      username: documentSnapshot['username'],
      fullName: documentSnapshot['full_name'],
      nickName: documentSnapshot['nick_name'],
      profilePhoto: documentSnapshot['profile_photo'],
      userRole: UserRoleModel.fromMap(documentSnapshot['role']),
    );
  }

  factory ProfileModel.fromEntity(ProfileEntity userProfileEntity) {
    return ProfileModel(
      uid: userProfileEntity.uid,
      username: userProfileEntity.username,
      fullName: userProfileEntity.fullName,
      nickName: userProfileEntity.nickName,
      profilePhoto: userProfileEntity.profilePhoto,
      userRole: userProfileEntity.userRole,
    );
  }

  factory ProfileModel.fromDetailEntity(DetailProfileEntity userProfileEntity) {
    return ProfileModel(
      uid: userProfileEntity.uid,
      username: userProfileEntity.username,
      fullName: userProfileEntity.fullName,
      nickName: userProfileEntity.nickName,
      profilePhoto: userProfileEntity.profilePhoto,
      userRole: userProfileEntity.userRole,
    );
  }
}
