import 'package:equatable/equatable.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/user_role_entity.dart';

class ProfileEntity extends Equatable {
  final String? uid;
  final String? username;
  final String? fullName;
  final String? profilePhoto;
  final UserRoleEntity? userRole;

  const ProfileEntity({
    this.uid,
    this.username,
    this.fullName,
    this.profilePhoto,
    this.userRole,
  });

  factory ProfileEntity.fromDetail(DetailProfileEntity detail) {
    return ProfileEntity(
      uid: detail.uid,
      username: detail.username,
      fullName: detail.fullName,
      profilePhoto: detail.profilePhoto,
      userRole: detail.userRole,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        username,
        fullName,
        profilePhoto,
        userRole,
      ];
}
