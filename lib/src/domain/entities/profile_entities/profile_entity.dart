import 'package:equatable/equatable.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/user_role_entity.dart';

class ProfileEntity extends Equatable {
  final String? uid;
  final String? username;
  final String? fullName;
  final String? nickName;
  final String? profilePhoto;
  final UserRoleEntity? userRole;

  const ProfileEntity({
    this.uid,
    this.username,
    this.fullName,
    this.nickName,
    this.profilePhoto,
    this.userRole,
  });

  factory ProfileEntity.fromDetail(DetailProfileEntity detail) {
    return ProfileEntity(
      uid: detail.uid,
      username: detail.username,
      fullName: detail.fullName,
      nickName: detail.nickName,
      profilePhoto: detail.profilePhoto,
      userRole: detail.userRole,
    );
  }

  ProfileEntity copyWith({
    String? uid,
    String? username,
    String? fullName,
    String? nickName,
    String? profilePhoto,
    UserRoleEntity? userRole,
  }) {
    return ProfileEntity(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      nickName: nickName ?? this.nickName,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      userRole: userRole ?? this.userRole,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        username,
        fullName,
        profilePhoto,
        nickName,
        userRole,
      ];
}
