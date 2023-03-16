import 'package:asco/src/domain/entities/assistance_entities/assistance_group_entity.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
import 'package:equatable/equatable.dart';

class UserPracticumEntity extends Equatable {
  // final String? practicumUid;
  final ClassroomEntity? classroom;
  final AssistanceGroupEntity? group;

  const UserPracticumEntity({
    this.group,
    this.classroom,
    // this.practicumUid,
  });

  factory UserPracticumEntity.fromDetail(UserPracticumEntity entity) {
    return UserPracticumEntity(
      group: entity.group,
      classroom: entity.classroom,
      // practicumUid: entity.practicumUid,
    );
  }

  @override
  List<Object?> get props => [
        // practicumUid,
        classroom,
        group,
      ];
}
