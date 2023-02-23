import 'package:equatable/equatable.dart';

class UserPracticumEntity extends Equatable {
  // final String? practicumUid;
  final String? classUid;
  final String? assistanceGroupUid;

  const UserPracticumEntity({
    this.assistanceGroupUid,
    this.classUid,
    // this.practicumUid,
  });

  factory UserPracticumEntity.fromDetail(UserPracticumEntity entity) {
    return UserPracticumEntity(
      assistanceGroupUid: entity.assistanceGroupUid,
      classUid: entity.classUid,
      // practicumUid: entity.practicumUid,
    );
  }

  @override
  List<Object?> get props => [
        // practicumUid,
        classUid,
        assistanceGroupUid,
      ];
}
