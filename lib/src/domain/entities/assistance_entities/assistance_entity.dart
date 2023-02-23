import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:equatable/equatable.dart';

class AssistanceGroupEntity extends Equatable {
  final String? uid;
  final String? practicumUid;
  final String? name;
  final ProfileEntity? assistant;
  final List<ProfileEntity>? students;

  const AssistanceGroupEntity({
    this.assistant,
    this.name,
    this.practicumUid,
    this.students,
    this.uid,
  });

  @override
  List<Object?> get props => [
        uid,
        practicumUid,
        name,
        assistant,
        students,
      ];
}
