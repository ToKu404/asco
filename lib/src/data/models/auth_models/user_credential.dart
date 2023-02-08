import 'package:asco/src/domain/entities/auth_entities/user_credential.dart';
import 'package:asco/src/domain/entities/auth_entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserCredentialModel extends UserCredentialEntity {
  const UserCredentialModel({required super.username, required super.roleId});

  Map<String, dynamic> toDocument() {
    return {
      "username": username,
      "roleId": roleId,
    };
  }

  UserCredentialEntity toEntity() {
    return UserCredentialEntity(
      username: username,
      roleId: roleId,
    );
  }

  factory UserCredentialModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserCredentialModel(
      username: documentSnapshot['username'],
      roleId: documentSnapshot['userId'],
    );
  }

  factory UserCredentialModel.fromEntity(UserEntity userEntity) {
    return UserCredentialModel(
      username: userEntity.username,
      roleId: userEntity.roleId,
    );
  }
}
