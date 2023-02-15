import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String? classOff;
  final String? fullName;
  final String? gender;
  final String? github;
  final String? username;
  final String? instagram;
  final String? nickName;
  final String? uid;
  final String? profilePhoto;

  const UserProfileEntity({
    this.classOff,
    this.fullName,
    this.gender,
    this.github,
    this.username,
    this.instagram,
    this.nickName,
    this.uid,
    this.profilePhoto,
  });

  @override
  List<Object?> get props => [
        classOff,
        fullName,
        gender,
        github,
        username,
        instagram,
        nickName,
        profilePhoto,
        uid,
      ];
}
