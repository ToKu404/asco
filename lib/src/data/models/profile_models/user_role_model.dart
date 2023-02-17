import 'package:asco/src/domain/entities/profile_entities/user_role_entity.dart';

class UserRoleModel extends UserRoleEntity {
  const UserRoleModel({
    super.name,
    super.id,
  });

  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'id': id,
    };
  }

  UserRoleEntity toEntity() {
    return UserRoleEntity(
      name: name,
      id: id,
    );
  }

  factory UserRoleModel.fromMap(Map<String, dynamic> documentSnapshot) {
    return UserRoleModel(
      name: documentSnapshot['name'],
      id: documentSnapshot['id'],
    );
  }

  factory UserRoleModel.fromEntity(UserRoleEntity userRole) {
    return UserRoleModel(
      name: userRole.name,
      id: userRole.id,
    );
  }
}
