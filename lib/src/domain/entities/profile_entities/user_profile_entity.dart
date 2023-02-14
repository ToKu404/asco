import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String? classOff;
  final String? fullName;
  final String? gender;
  final String? github;
  final String? id;
  final String? instagram;
  final String? nickName;
  final String? profilePhoto;

  const UserProfileEntity({
    this.classOff,
    this.fullName,
    this.gender,
    this.github,
    this.id,
    this.instagram,
    this.nickName,
    this.profilePhoto,
  });

  @override
  List<Object?> get props => [
        classOff,
        fullName,
        gender,
        github,
        id,
        instagram,
        nickName,
        profilePhoto,
      ];
}
