import 'package:asco/src/data/datasources/helpers/ds_helper.dart';
import 'package:asco/src/data/models/profile_models/user_practicum_model.dart';
import 'package:asco/src/data/models/profile_models/user_role_model.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailProfileModel extends DetailProfileEntity {
  const DetailProfileModel({
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
    super.userPracticums,
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
      // 'user_practicums': (userPracticums != null)
      //     ? userPracticums!
      //         .map((e) => UserPracticumModel.fromEntity(e))
      //         .toList()
      //     : [],
      "user_practicums": (userPracticums != null)
          ? {
              for (var k in userPracticums!.keys)
                k: UserPracticumModel.fromEntity(userPracticums![k]!)
                    .toDocument()
            }
          : null,
      'uid': uid,
      if (userRole != null)
        'role': {
          'id': userRole!.id,
          'name': userRole!.name,
        }
    };
  }

  DetailProfileEntity toEntity() {
    return DetailProfileEntity(
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
      userPracticums: userPracticums,
    );
  }

  factory DetailProfileModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final map = ReadHelper.isKeyExist(documentSnapshot, 'user_practicums')
        ? documentSnapshot['user_practicums'] as Map<String, dynamic>
        : null;
    return DetailProfileModel(
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
      userPracticums: map != null
          ? {
              for (String k in map.keys)
                k: UserPracticumModel.fromMap(map[k]).toEntity(),
            }
          : null,
    );
  }

  factory DetailProfileModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return DetailProfileModel(
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
        documentSnapshot['role'],
      ),
    );
  }

  factory DetailProfileModel.fromEntity(DetailProfileEntity userProfileEntity) {
    return DetailProfileModel(
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
      userPracticums: userProfileEntity.userPracticums,
    );
  }
}
