import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/src/domain/entities/auth_entities/user_credential_entity.dart';
import 'package:asco/src/domain/entities/auth_entities/user_entity.dart';

class UserCredentialModel extends UserCredentialEntity {
  const UserCredentialModel({required super.username, required super.roleId});

  Map<String, dynamic> toDocument() {
    return {
      "roleId": roleId,
      "username": username,
    };
  }

  UserCredentialEntity toEntity() {
    return UserCredentialEntity(
      roleId: roleId,
      username: username,
    );
  }

  factory UserCredentialModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserCredentialModel(
      roleId: documentSnapshot['userId'],
      username: documentSnapshot['username'],
    );
  }

  factory UserCredentialModel.fromEntity(UserEntity userEntity) {
    return UserCredentialModel(
      roleId: userEntity.roleId,
      username: userEntity.username,
    );
  }
}
