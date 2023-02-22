import 'package:asco/src/domain/entities/profile_entities/user_role_entity.dart';
import 'package:equatable/equatable.dart';

class DetailProfileEntity extends Equatable {
  final String? classOf;
  final String? fullName;
  final String? gender;
  final String? github;
  final String? username;
  final String? instagram;
  final String? nickName;
  final String? uid;
  final String? profilePhoto;
  final UserRoleEntity? userRole;

  const DetailProfileEntity({
    this.classOf,
    this.fullName,
    this.gender,
    this.github,
    this.username,
    this.instagram,
    this.nickName,
    this.uid,
    this.profilePhoto,
    this.userRole,
  });

  @override
  List<Object?> get props => [
        classOf,
        fullName,
        gender,
        github,
        username,
        instagram,
        nickName,
        profilePhoto,
        uid,
        userRole,
      ];
}
