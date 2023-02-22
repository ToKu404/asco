import 'package:asco/src/domain/entities/profile_entities/user_role_entity.dart';
import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String? fullName;
  final String? username;
  final String? uid;
  final String? profilePhoto;
  final UserRoleEntity? userRole;

  const ProfileEntity({
    this.fullName,
    this.username,
    this.uid,
    this.profilePhoto,
    this.userRole,
  });

  @override
  List<Object?> get props => [
        fullName,
        username,
        profilePhoto,
        uid,
        userRole,
      ];
}
