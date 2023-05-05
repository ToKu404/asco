import 'package:equatable/equatable.dart';
import 'package:asco/src/domain/entities/profile_entities/user_practicum_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/user_role_entity.dart';

class DetailProfileEntity extends Equatable {
  final String? uid;
  final String? username;
  final String? fullName;
  final String? nickName;
  final String? gender;
  final String? classOf;
  final String? github;
  final String? instagram;
  final String? profilePhoto;
  final UserRoleEntity? userRole;
  final Map<String, UserPracticumEntity>? userPracticums;

  const DetailProfileEntity({
    this.uid,
    this.username,
    this.fullName,
    this.nickName,
    this.gender,
    this.classOf,
    this.github,
    this.instagram,
    this.profilePhoto,
    this.userRole,
    this.userPracticums,
  });

  DetailProfileEntity copyWith({
    String? uid,
    String? username,
    String? fullName,
    String? nickName,
    String? gender,
    String? classOf,
    String? github,
    String? instagram,
    String? profilePhoto,
    UserRoleEntity? userRole,
    Map<String, UserPracticumEntity>? userPracticums,
  }) {
    return DetailProfileEntity(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      nickName: nickName ?? this.nickName,
      gender: gender ?? this.gender,
      classOf: classOf ?? this.classOf,
      github: github ?? this.github,
      instagram: instagram ?? this.instagram,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      userRole: userRole ?? this.userRole,
      userPracticums: userPracticums ?? this.userPracticums,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        username,
        fullName,
        nickName,
        gender,
        classOf,
        github,
        instagram,
        profilePhoto,
        userRole,
        userPracticums,
      ];
}
