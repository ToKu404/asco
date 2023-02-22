import 'package:asco/src/data/models/profile_models/user_role_model.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    super.fullName,
    super.username,
    super.profilePhoto,
    super.uid,
    super.userRole,
  });

  Map<String, dynamic> toDocument() {
    return {
      'full_name': fullName,
      'username': username,
      'profile_photo': profilePhoto,
      'uid': uid,
      if (userRole != null)
        'role': {
          'id': userRole!.id,
          'name': userRole!.name,
        }
    };
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      fullName: fullName,
      username: username,
      profilePhoto: profilePhoto,
      uid: uid,
      userRole: userRole,
    );
  }

  factory ProfileModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return ProfileModel(
      fullName: documentSnapshot['full_name'],
      username: documentSnapshot['username'],
      profilePhoto: documentSnapshot['profile_photo'],
      uid: documentSnapshot['uid'],
      userRole: UserRoleModel.fromMap(
        documentSnapshot.get('role'),
      ),
    );
  }

  factory ProfileModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return ProfileModel(
      fullName: documentSnapshot['full_name'],
      username: documentSnapshot['username'],
      profilePhoto: documentSnapshot['profile_photo'],
      uid: documentSnapshot['uid'],
      userRole: UserRoleModel.fromMap(
        documentSnapshot['role'],
      ),
    );
  }

  factory ProfileModel.fromEntity(ProfileEntity userProfileEntity) {
    return ProfileModel(
      fullName: userProfileEntity.fullName,
      username: userProfileEntity.username,
      profilePhoto: userProfileEntity.profilePhoto,
      uid: userProfileEntity.uid,
      userRole: userProfileEntity.userRole,
    );
  }

  factory ProfileModel.fromDetailEntity(DetailProfileEntity userProfileEntity) {
    return ProfileModel(
      fullName: userProfileEntity.fullName,
      username: userProfileEntity.username,
      profilePhoto: userProfileEntity.profilePhoto,
      uid: userProfileEntity.uid,
      userRole: userProfileEntity.userRole,
    );
  }
}
