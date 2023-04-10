import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/src/data/models/profile_models/user_practicum_model.dart';
import 'package:asco/src/data/models/profile_models/user_role_model.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/user_practicum_entity.dart';

class DetailProfileModel extends DetailProfileEntity {
  const DetailProfileModel({
    super.uid,
    super.username,
    super.fullName,
    super.nickName,
    super.gender,
    super.classOf,
    super.github,
    super.instagram,
    super.profilePhoto,
    super.userRole,
    super.userPracticums,
  });

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'username': username,
      'full_name': fullName,
      'nick_name': nickName,
      'gender': gender,
      'class_of': classOf,
      'github': github,
      'instagram': instagram,
      'profile_photo': profilePhoto,
      if (userRole != null)
        'role': {
          'id': userRole!.id,
          'name': userRole!.name,
        },
      'user_practicums': (userPracticums != null)
          ? {
              for (var key in userPracticums!.keys)
                key: UserPracticumModel.fromEntity(userPracticums![key]!)
                    .toDocument()
            }
          : null,
    };
  }

  DetailProfileEntity toEntity() {
    return DetailProfileEntity(
      uid: uid,
      username: username,
      fullName: fullName,
      nickName: nickName,
      gender: gender,
      classOf: classOf,
      github: github,
      instagram: instagram,
      profilePhoto: profilePhoto,
      userRole: userRole,
      userPracticums: userPracticums,
    );
  }

  factory DetailProfileModel.fromSnapshot(
    DocumentSnapshot documentSnapshot,
    Map<String, UserPracticumEntity>? userPracticums,
  ) {
    return DetailProfileModel(
      uid: documentSnapshot['uid'],
      username: documentSnapshot['username'],
      fullName: documentSnapshot['full_name'],
      nickName: documentSnapshot['nick_name'],
      gender: documentSnapshot['gender'],
      classOf: documentSnapshot['class_of'],
      github: documentSnapshot['github'],
      instagram: documentSnapshot['instagram'],
      profilePhoto: documentSnapshot['profile_photo'],
      userRole: UserRoleModel.fromMap(documentSnapshot.get('role')),
      userPracticums: userPracticums,
      
    );
  }

  factory DetailProfileModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return DetailProfileModel(
      uid: documentSnapshot['uid'],
      username: documentSnapshot['username'],
      fullName: documentSnapshot['full_name'],
      nickName: documentSnapshot['nick_name'],
      gender: documentSnapshot['gender'],
      classOf: documentSnapshot['class_of'],
      github: documentSnapshot['github'],
      instagram: documentSnapshot['instagram'],
      profilePhoto: documentSnapshot['profile_photo'],
      userRole: UserRoleModel.fromMap(documentSnapshot['role']),
    );
  }

  factory DetailProfileModel.fromEntity(DetailProfileEntity userProfileEntity) {
    return DetailProfileModel(
      uid: userProfileEntity.uid,
      username: userProfileEntity.username,
      fullName: userProfileEntity.fullName,
      nickName: userProfileEntity.nickName,
      gender: userProfileEntity.gender,
      classOf: userProfileEntity.classOf,
      github: userProfileEntity.github,
      instagram: userProfileEntity.instagram,
      profilePhoto: userProfileEntity.profilePhoto,
      userRole: userProfileEntity.userRole,
      userPracticums: userProfileEntity.userPracticums,
    );
  }
}
