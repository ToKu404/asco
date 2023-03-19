import 'package:asco/src/domain/entities/profile_entities/user_role_entity.dart';

class UserRoleModel extends UserRoleEntity {
  const UserRoleModel({super.id, super.name});

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
    };
  }

  UserRoleEntity toEntity() {
    return UserRoleEntity(
      id: id,
      name: name,
    );
  }

  factory UserRoleModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return UserRoleModel(
      id: documentSnapshot['id'],
      name: documentSnapshot['name'],
    );
  }

  factory UserRoleModel.fromEntity(UserRoleEntity userRole) {
    return UserRoleModel(
      id: userRole.id,
      name: userRole.name,
    );
  }
}
