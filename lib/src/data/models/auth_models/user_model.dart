import 'package:asco/src/domain/entities/auth_entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required super.username,
      required super.password,
      required super.roleId});

  Map<String, dynamic> toDocument() {
    return {
      "username": username,
      "password": password,
      "roleId": roleId,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      username: username,
      password: password,
      roleId: roleId,
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      username: documentSnapshot['username'],
      password: documentSnapshot['password'],
      roleId: documentSnapshot['userId'],
    );
  }

  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
      username: userEntity.username,
      password: userEntity.password,
      roleId: userEntity.roleId,
    );
  }
}
