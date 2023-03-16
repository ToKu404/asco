import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/src/domain/entities/auth_entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.roleId,
    required super.username,
    required super.password,
  });

  Map<String, dynamic> toDocument() {
    return {
      "roleId": roleId,
      "username": username,
      "password": password,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      roleId: roleId,
      username: username,
      password: password,
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      roleId: documentSnapshot['userId'],
      username: documentSnapshot['username'],
      password: documentSnapshot['password'],
    );
  }

  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
      roleId: userEntity.roleId,
      username: userEntity.username,
      password: userEntity.password,
    );
  }
}
