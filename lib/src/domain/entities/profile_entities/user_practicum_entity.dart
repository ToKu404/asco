import 'package:equatable/equatable.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_group_entity.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';

class UserPracticumEntity extends Equatable {
  final ClassroomEntity? classroom;
  final AssistanceGroupEntity? group;
  // final String? practicumUid;

  const UserPracticumEntity({this.classroom, this.group});

  factory UserPracticumEntity.fromDetail(UserPracticumEntity entity) {
    return UserPracticumEntity(
      classroom: entity.classroom,
      group: entity.group,
    );
  }

  @override
  List<Object?> get props => [classroom, group];
}
